# RubyDiff

This is a port to Ruby of part of @yinwang0's [psydiff](https://github.com/yinwang0/psydiff). Specifically, I've ported the htmlizer part of his app, which converts a semantic diff into an html page which can be viewed in a webbrowser to make visual the information contained in the diff.  @yinwang0
has written extensively about semantic diffing [on his blog](http://yinwang0.wordpress.com/2012/01/03/ydiff/) and also about [psydiff](http://yinwang0.wordpress.com/2013/07/06/psydiff/).

I created this port to demonstrate the use of the NodeDiff classes
I recently added to [JRubyParser](https://github.com/jruby/jruby-parser) and
to serve as an example of using it. I should make clear that JRubyParser and
said NodeDiff classes are entirely unrelated to psydiff, except that they do
something quite similar (create a diff of source code based on the AST rather than comparing the text directly).

This application should especially serve as an example of using the subdiff's
produced by NodeDiff to improve the quality of the output. See `bin/ruby_diff`
.


## Usage

To run this, you'll need to have `JRuby` and the `jruby-parser` gem installed. Then run `bin/ruby_diff` along with the paths to two versions of a ruby source file.

    bin/ruby_diff example/bar.rb example/foo.rb

This will output an html file you can open in your browser. Check out `foo.rb-bar.rb.html` for a sample of the output.
