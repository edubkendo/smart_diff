require "smart_diff"
import org.jrubyparser.lexer.SyntaxException

describe "SmartDiff" do
  before(:each) do
    @rd = SmartDiff.new 'example/foo.rb', 'example/bar.rb'
  end

  it "should take two filenames" do
    @rd.file_one.should == 'example/foo.rb'
    @rd.file_two.should == 'example/bar.rb'
  end

  it "should read two files in as strings" do
    @rd.read(@rd.file_one).class.should == String
  end

  it "should raise an exception if the file does not exist" do
    expect { @rd.read('foo/foofile.rb') }.to raise_error(StandardError)
  end

  it "should parse the files into ASTs" do
    code_for_parse = @rd.read(@rd.file_one)
    @rd.parse(code_for_parse, @rd.file_one).instance_of?(org.jrubyparser.ast.RootNode).should be(true)
  end

  it "should raise an exception if the code is invalid ruby" do
    code_for_parse = "Def BadRubyCodeIsBAda end puts cLas$"
    expect { @rd.parse(code_for_parse, @rd.file_one) }.to raise_error(SyntaxException)
  end

  it "should create a diff of the two ASTs" do
    @rd.node_diff.size.should >= 1
  end
end


