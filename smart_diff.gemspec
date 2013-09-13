files = `git ls-files -- doc/* example/* lib/* spec/* web/*`.split("\n")

Gem::Specification.new do |s|
  s.name        = 'smart_diff'
  s.version     = '0.0.1'
  s.date        = '2013-09-08'
  s.summary     = "Ruby clone of psydiff"
  s.description = "Create Semantic Diffs of Ruby source code based on the AST."
  s.authors     = ["Eric West"]
  s.email       = 'esw9999@gmail.com'
  s.files       =
                  [
                    "bin/smart_diff",
                    "README.md",
                    "foo.rb-bar.rb.html",
                    "Rakefile"
                  ]
  s.files << files
  s.executables  << 'smart_diff'
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.platform    = Gem::Platform::RUBY
  s.has_rdoc    = 'yard'
  s.homepage    =
    'http://github.com/edubkendo/smart_diff.git'
  s.license       = 'GPL'
  s.add_dependency 'jruby-parser', '~> 0.5.1'
  s.add_development_dependency 'rspec' '~> 2.14.0'
  s.add_development_dependency 'yard'
end
