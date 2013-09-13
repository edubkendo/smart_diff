require "smart_diff/htmlize"

describe "Htmlize" do

  it "should clear the uid variables" do
    html = Htmlize.new
    html.uid_count = 10
    html.uid_hash = { :foo => "bar", :baz => "qux" }
    html.clear_uid()
    html.uid_count.should == -1
    html.uid_hash.should == {}
  end

  it "should increment the uid_count" do
    html = Htmlize.new
    html.uid_count = 5
    html.uid("banana")
    html.uid_count.should == 6
  end

  it "should set the hash if it wasn't previously set" do
    html = Htmlize.new
    html.uid(:cow)
    html.uid_hash.should have_key(:cow)
  end

  it "should return the entry for a previously set hash" do
    html = Htmlize.new
    html.uid_hash = { banana: "cow" }
    html.uid(:banana).should =~ /cow/
  end

end
