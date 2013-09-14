require "pathname"

module Utils
  module_function


  #
  # Where in the file-system is smart_diff installed?
  #
  # @return [Pathname] the path to the installation of smart_diff
  def get_install_path
    utils_path = Pathname.new(__FILE__).dirname
    # There should be a more elegant way to do this
    install_path = utils_path.parent.parent
  end


  #
  # Get a node's start position,
  #
  # @param  node [org.jrubyparser.Node] a node in an abstract syntax tree
  #
  # @return [Fixnum] Number representing the node's start offset.
  def node_start(node)
    node.position.start_offset
  end


  #
  # Get a node's end position.
  #
  # @param  node [org.jrubyparser.Node] a node in an abstract syntax tree
  #
  # @return [Fixnum] Number representing the node's end offset.
  def node_end(node)
    node.position.end_offset
  end


  #
  # Determines if the node beginning with nd_start and ending with nd_end
  # falls inside an anchor. In other words, is the current node inside
  # another node _which also changed_ and has a match in the other file. (If it
  # is an insertion or deletion it gets wrapped in a span so we aren't
  # concerned with those.)
  #
  # In a pair of tags, the opening tag only has some of the position
  # information, so they are marked with a meaningless -1. But the closing tags
  # have the information needed- start and end offsets.
  #
  # Subnodes were added to the array after the outer nodes, so we check them
  # here, once, against each tag, and decide how to process them as we
  # generate the HTML.
  #
  # @param  tags [Array] A list of all tags so far recorded.
  # @param  nd_start [Fixnum] Number representing the node's starting position.
  # @param  nd_end [Fixnum] Number representing the node's ending position.
  #
  # @return [TrueClass, FalseClass] Is it inside an anchor?
  def inside_anchor?(tags, nd_start, nd_end)
      tags.each do |t|
        if nd_end < t.idx && nd_start > t.start && t.start != -1
          return true
        end
      end
      return false
  end

end
