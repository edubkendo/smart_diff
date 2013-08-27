require "uri"

class Tag
  attr_accessor :tag, :idx, :start

  def initialize(tag, idx, start=-1)
    @tag = tag
    @idx = idx
    @start = start
  end

end

class Htmlize
  attr_accessor :uid_count, :uid_hash

  def initialize
    @uid_count = -1
    @uid_hash = {}
  end

  def clear_uid()
    @uid_count = -1
    @uid_hash = {}
  end

  def uid(node)
    if @uid_hash.include?(node)
      return @uid_hash[node]
    end

    @uid_count = @uid_count + 1
    @uid_hash[node] = @uid_count.to_s
  end


end
