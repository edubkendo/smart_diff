require "rspec/core/rake_task"
require 'bundler'
Bundler::GemHelper.install_tasks

desc "Run specs"
RSpec::Core::RakeTask.new do |r|
  r.ruby_opts = "-J-ea -Ilib"
end

desc "Build gem"
task :build_gem => [:spec, :build] do
  puts "Building gem with Bundler"
end
