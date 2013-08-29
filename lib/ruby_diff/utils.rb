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

end
