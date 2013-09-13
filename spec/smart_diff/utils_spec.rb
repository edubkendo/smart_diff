require "smart_diff/utils"

class Position
  def start_offset
    600
  end

  def end_offset
    750
  end
end

class TestNode
  def position
    Position.new
  end

end

describe "Utils" do
  include Utils

  it "should return a nodes start position" do
    tn = TestNode.new
    start = node_start(tn)
    start.should == 600
  end

  it "should return a nodes end position" do
    tn = TestNode.new
    nd_end = node_end(tn)
    nd_end.should == 750
  end
end
