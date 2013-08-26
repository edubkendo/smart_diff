require "jruby-parser"
require "pathname"
require "jruby-parser.jar"

import org.jrubyparser.util.diff.NodeDiff

class RubyDiff
  attr_accessor :file_one, :file_two, :node_diff

  def initialize(file_one, file_two)
    @file_one = file_one
    @file_two = file_two
    node_one = parse(@file_one)
    node_two = parse(@file_two)
    @node_diff = diff(node_one, node_two)
  end

  def read(file_name)
    path = Pathname.new(file_name).expand_path
    if path.exist?
      File.read path
    end
  end

  def parse(file_name)
    code_to_parse = read(file_name)
    JRubyParser.parse(code_to_parse, { :filename => file_name })
  end

  def diff(nodeA, nodeB)
    nd = org.jrubyparser.util.diff.NodeDiff.new(nodeA, nodeB)
    nd.deep_diff
  end
end

#     @node_diff = diff(first_node, second_node)

    # first_node = parse(@file_one)
    # second_node = parse(@file_two)
