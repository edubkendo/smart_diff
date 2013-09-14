# SmartDiff

This is a port to Ruby of part of @yinwang0's [psydiff](https://github.com/yinwang0/psydiff). Specifically, I've ported the htmlizer part of his app, which converts a semantic diff into an html page which can be viewed in a webbrowser to make visual the information contained in the diff.  @yinwang0
has written extensively about semantic diffing [on his blog](http://yinwang0.wordpress.com/2012/01/03/ydiff/) and also about [psydiff](http://yinwang0.wordpress.com/2013/07/06/psydiff/).

I created this port to demonstrate the use of the NodeDiff classes
I recently added to [JRubyParser](https://github.com/jruby/jruby-parser) and
to serve as an example of using it. I should make clear that JRubyParser and
said NodeDiff classes are entirely unrelated to psydiff, except that they do
something quite similar (create a diff of source code based on the AST rather than comparing the text directly).

This application should especially serve as an example of using the subdiff's
produced by NodeDiff to improve the quality of the output. See `bin/smart_diff`
 or [check out the docs](http://rubydoc.info/gems/smart_diff/0.0.1/frames).

## Install


    $ jruby -S gem install smart_diff


## Usage

Run `smart_diff` along with the paths to two versions of a ruby source file.

    smart_diff example/bar.rb example/foo.rb

This will output an html file you can open in your browser. Check out `foo.rb-bar.rb.html` for a sample of the output.

LICENSE

Copyright (C) 2011-2013 Yin Wang

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
