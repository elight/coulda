require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

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

desc 'Default: run tests.'
task :default => 'test'
