require "cgi"
require_relative "utils.rb"


#
# A Tag wrapping an element in an HTML file.
# It contains information about the node wrapped inside
# it such as the start and end offset. The `tag` attr contains
# the actual HTML, and includes information used to style the nodes
# based on whether its an insertion, deletion or modification.
# Matching modifications are wrapped in anchor tags so they can be
# linked to their matches.
#
#
class Tag
  attr_accessor :tag, :idx, :start


  #
  # Construct a new tag.
  #
  # @param  tag [String] An HTML tag.
  # @param  idx [Fixnum] The start of the node's offset for an opening tag,
  # The end offset of the node if it is a closing tag.
  # @param  start [Fixnum] Left -1 for an open tag, the node's start offset
  # for a closing tag.
  #
  # @return [Tag] The Tag which was constructed.
  def initialize(tag, idx, start=-1)
    @tag = tag
    @idx = idx
    @start = start
  end


  #
  # String representation of the Tag object.
  #
  # @return [String] Tag as string.
  def to_s
    "tag: #{@tag}, idx: #{@idx} start: #{@start}"
  end

end


#
# Given information about two Ruby files, and their
# semantic diff, creates an HTML file to represent the
# diff information in an intuitive and appealing visual
# format.
#
class Htmlize
  include Utils
  attr_accessor :uid_count, :uid_hash

  def initialize
    @uid_count = -1
    @uid_hash = {}
  end

  def clear_uid()
    @uid_count = -1
    @uid_hash = {}
  end


  #
  # Give the node a uid, place it in the uid hash and
  # up the count. If it already has one, fetch it from the hash
  # and return it.
  #
  # @param  node [org.jrubyparser.Node] A node in the AST.
  #
  # @return [Fixnum] The uid of the node passed in.
  def uid(node)
    if @uid_hash.has_key?(node)
      return @uid_hash[node]
    end

    @uid_count = @uid_count + 1
    @uid_hash[node] = @uid_count.to_s
  end


  #
  # Construct the HTML for the top of the file.
  #
  # @return [String] HTML header.
  def html_header
    install_path = get_install_path

    js_filename = Pathname.new(install_path).join('web/nav.js')
    js_text = js_filename.read

    css_filename = Pathname.new(install_path).join('web/diff.css')
    css_text = css_filename.read

    out = %Q{<html>\n
    <head>\n
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">\n
    <style>\n
    #{css_text}
    \n</style>\n
    <script type="text/javascript">\n
    #{js_text}
    \n</script>\n
    </head>\n
    <body>\n}
  end


  #
  # Create the html for the bottom of the page.
  #
  # @return [String] the html footer.
  def html_footer
    out = %Q{</body>\n
             </html>\n}
  end


  #
  # Takes in the text and outputs htmls.
  #
  # @param  text [String] the text from either side of the diff, w/ html tags.
  # @param  side [String] left or right
  #
  # @return [String] All the html for one side of the diff.
  def write_html(text, side)
    out = ""

    out << '<div id="' + side + '" class="src">'
    out << '<pre>'

    if side == 'left'
      out << '<a id="leftstart" tid="rightstart"></a>'
    else
      out << '<a id="rightstart" tid="leftstart"></a>'
    end

    out << text
    out << '</pre>'
    out << '</div>'
  end


  #
  # Takes in the information about the diff and writes out a file of HTML.
  #
  # @param  changes [Array] An array of Changes, the diff
  # @param  file1 [String] path to the first file.
  # @param  file2 [String] path to the second file.
  # @param  text1 [String] the text from the first file
  # @param  text2 [String] the text from the second file.
  #
  # @return [String] The name of the HTML file that was written.
  def create_html(changes, file1, file2, text1, text2)
    tags1 = change_tags(changes, 'left')
    tags2 = change_tags(changes, 'right')
    tagged_text1 = apply_tags(text1, tags1)
    tagged_text2 = apply_tags(text2, tags2)

    output_filename = "#{Pathname.new(file1).basename}-#{Pathname.new(file2).basename}.html"
    File.open(output_filename, "w") do |f|
      f.write html_header
      f.write write_html(tagged_text1, 'left')
      f.write write_html(tagged_text2, 'right')
      f.write html_footer
    end
    output_filename

  end


  #
  # Does HTML escaping on both tags and text, and places the tags around the
  # appropriate text.
  #
  # @param  s [String] The text from one of the files.
  # @param  tags [String] The tags belonging to one of the files.
  #
  # @return [String] The tagged text.
  def apply_tags(s, tags)
    tags = tags.sort_by { |x| [x.idx, -x.start] }
    curr = 0
    out = ""
    tags.each do |t|
      while curr < t.idx && curr < s.length
        out << CGI::escapeHTML(s[curr])
        curr += 1
      end
      out << t.tag
    end
    while curr < s.length
      out << CGI::escapeHTML(s[curr])
      curr += 1
    end
    return out
  end


  #
  # Works through the Change objects in the diff, creating the
  # appropriate HTML tags for each.
  #
  # @param  changes [Array] An array of Change objects.
  # @param  side [String] Tells us which side of the page to create tags for.
  #
  # @return [Array] The tags to place around the text.
  def change_tags(changes, side)
    tags = []
    changes.each do |c|

      key = side =~ /left/ ? c.old_node : c.new_node
      if key
        nd_start = node_start(key)
        nd_end = node_end(key)

        if c.old_node && c.new_node
          if inside_anchor?(tags, nd_start, nd_end)
            if change_class(c) =~ /c/
              # no op
              # we don't nest anchors inside other anchors
            else
              # In this case, we have an insertion or deletion
              tags << Tag.new(span_start(c), nd_start)
              tags << Tag.new('</span>', nd_end, nd_start)
            end
          else
            # Link up the matching nodes with anchor tags
            tags << Tag.new(link_start(c, side), nd_start)
            tags << Tag.new('</a>', nd_end, nd_start)
          end
        else
          # Wrap a span around the insertion or deletion.
          tags << Tag.new(span_start(c), nd_start)
          tags << Tag.new('</span>', nd_end, nd_start)
        end
      end
    end
    return tags
  end


  #
  # Determines whether the change is an insertion, deletion or modification.
  #
  # @param  change [Change] The Change object to be checked.
  #
  # @return [String] Either a 'c', 'd', or 'i'
  def change_class(change)
    if !change.old_node
      return 'd'
    elsif !change.new_node
      return 'i'
    else
      return 'c'
    end
  end


  #
  # Takes a Change and creates a span tag.
  #
  # @param  change [Change] A single change from the diff representing either
  # an insertion or deletion.
  #
  # @return [String] A span tag based on the Change passed in.
  def span_start(change)
    "<span class=#{qs(change_class(change))}>"
  end


  #
  # Create anchor tags for a Change object.
  #
  # @param  change [Change] The Change object to be wrapped.
  # @param  side [String] Which side of the page, in other words, which file?
  #
  # @return [String] An anchor tag.
  def link_start(change, side)
    cls = change_class(change)

    if side == 'left'
      me, other = change.old_node, change.new_node
    else
      me, other = change.new_node, change.old_node
    end

    "<a id=#{qs(uid(me))} tid=#{qs(uid(other))} class=#{qs(cls)}>"
  end


  #
  # Takes a string and returns it in quotes.
  #
  # @param  s [String] A string to be quoted.
  #
  # @return [String] The quoted string.
  def qs(s)
    "'#{s}'"
  end

end
