require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

require 'lib/coulda/tasks'

gem 'thoughtbot-shoulda'
require 'shoulda'

# Test::Unit::UI::VERBOSE
test_files_pattern = 'test/**/*_test.rb'
src_files_pattern = 'src/**/*.rb'

Rake::TestTask.new do |t|
  src_files = Dir[src_files_pattern]
  src_files.each { |f| puts f; require f[0...-3] }
  t.pattern = test_files_pattern
  t.verbose = false
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "coulda"
    s.version = "0.1.1"
    s.authors = ["Evan David Light"]
    s.email = "evan@tiggerpalace.com"
    s.summary = "Behaviour Driven Development derived from Cucumber but as an internal DSL with methods for reuse"
    s.homepage = "http://evan.tiggerpalace.com/"
    s.description = "Behaviour Driven Development derived from Cucumber but as an internal DSL with methods for reuse"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end


desc 'Default: run tests.'
task :default => 'test'
