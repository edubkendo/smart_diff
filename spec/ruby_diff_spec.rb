require "ruby_diff"

describe "RubyDiff" do
  before(:each) do
    @rd = RubyDiff.new 'example/foo.rb', 'example/bar.rb'
  end

  it "should take two filenames" do
    @rd.file_one.should == 'example/foo.rb'
    @rd.file_two.should == 'example/bar.rb'
  end

  it "should read two files in as strings" do
    @rd.read(@rd.file_one).class.should == String
  end

  it "should parse the files into ASTs" do
    @rd.parse(@rd.file_one).instance_of?(org.jrubyparser.ast.RootNode).should be(true)
  end

  it "should create a diff of the two ASTs" do
    @rd.node_diff.size.should == 6
  end
end
