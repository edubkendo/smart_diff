require "pathname"
require "filetree/simple_tree"

class Pathname
  alias :_parent :parent
  alias :_children :children
end

class FileTree < Pathname
  include SimpleTree

  attr_accessor :name, :id, :identifier

  def name
    @name ||= self.inspect
  end

  def id
    @id ||= self.inspect
  end

  def identifier
    @identifier ||= self.inspect
  end

  #
  # See {http://rubydoc.info/stdlib/pathname/Pathname:parent Pathname.parent}
  #
  # @return [FileTree] The directory immediately above self.
  #
  def parent
    puts "Here's Johnny!"
    FileTree.new(_parent)
  end

  #
  # See {http://rubydoc.info/stdlib/pathname/Pathname:children Pathname.children}
  #
  # @return [Array] an Array of all entries contained in self.
  #
  def children(*args)
    if self.directory?
      _children(*args)
    else
      []
    end
  end

end

puts "And now for something completely different"
