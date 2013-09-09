Gem::Specification.new do |s|
  s.name        = 'ruby_diff'
  s.version     = '0.0.1'
  s.date        = '2013-09-08'
  s.summary     = "Ruby clone of psydiff"
  s.description = "Create Semantic Diffs of Ruby source code based on the AST."
  s.authors     = ["Eric West"]
  s.email       = 'esw9999@gmail.com'
  s.files       =
                  [
                    "lib/ruby_diff.rb",
                    "lib/ruby_diff/htmlize.rb",
                    "lib/ruby_diff/utils.rb",
                    "bin/ruby_diff",
                    "example/foo.rb",
                    "example/bar.rb",
                    "spec/ruby_diff_spec.rb",
                    "spec/htmlize_spec.rb",
                    "spec/utils_spec.rb",
                    "web/nav.js",
                    "web/diff.css",
                    "README.md",
                    "Rakefile"
                  ]
  s.executables  << 'ruby_diff'
  s.platform    = Gem::Platform::RUBY
  s.homepage    =
    'http://github.com/edubkendo/RubyDiff.git'
  s.license       = 'GPL'
  s.add_dependency 'jruby-parser', '~> 0.5.1'
  s.add_development_dependency 'rspec' '~> 2.14.0'
end
