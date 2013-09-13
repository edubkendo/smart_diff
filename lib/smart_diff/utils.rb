require "pathname"

module Utils
  module_function

  def get_install_path
    utils_path = Pathname.new(__FILE__).dirname
    # There should be a more elegant way to do this
    install_path = utils_path.parent.parent
  end

  def node_start(node)
    node.position.start_offset
  end

  def node_end(node)
    node.position.end_offset
  end

  def inside_anchor?(tags, nd_start, nd_end)
      tags.each do |t|
        if nd_end < t.idx && nd_start > t.start && t.start != -1
          return true
        end
      end
      return false
  end

end
