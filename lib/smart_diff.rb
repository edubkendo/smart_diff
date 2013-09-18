require "jruby-parser"
require "pathname"
require "jruby-parser.jar"

import org.jrubyparser.util.diff.NodeDiff

class SmartDiff
  attr_accessor :file_one, :file_two, :code_one, :code_two, :node_diff


  #
  # Create a SmartDiff object which will create diff of two source
  # files based on AST generated by JRubyParser.
  #
  # @param  file_one [String] The path to the first source file.
  # @param  file_two [String] The path to the second source file.
  #
  # @return [SmartDiff] A Ruby object which holds a reference to a diff.
  def initialize(file_one, file_two)
    @file_one = file_one
    @file_two = file_two
    @node_diff = diff()
  end


  #
  # Read the source code into a string.
  #
  # @param  file_name [String] the path to a file containing ruby source
  #
  # @return [String] The code read in from the file path passed in.
  def read(file_name)
    path = Pathname.new(file_name).expand_path
    if path.exist?
      File.read path
    else
      raise "#{path} not found. Check the path."
    end
  end


  #
  # Parse the source into an abstract syntax tree.
  #
  # @param  code_to_parse [String] Ruby source code.
  # @param  file_name [String] The path to the file containing code_to_parse
  #
  # @return [org.jrubyparser.Node] A Node object representing the code as AST.
  def parse(code_to_parse, file_name)
    JRubyParser.parse(code_to_parse, { :filename => file_name })
  end


  #
  # Create a diff of the two AST objects.
  #
  # @return [java.util.ArrayList<DeepDiff>] The differences.
  def diff()
    @code_one = read(@file_one)
    @code_two = read(@file_two)
    if @code_one && @code_two
      nodeA = parse(@code_one, @file_one)
      nodeB = parse(@code_two, @file_two)
      nd = org.jrubyparser.util.diff.NodeDiff.new(nodeA, @code_one, nodeB, @code_two)
      nd.deep_diff
    end
  end
end
