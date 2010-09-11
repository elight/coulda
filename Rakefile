require 'rubygems'
require 'rake'
require 'rake/testtask'

gem 'shoulda'
require 'shoulda'

# Test::Unit::UI::VERBOSE
Rake::TestTask.new('test') do |t|
  t.libs << 'test'
  src_files = Dir.glob('src/**/*.rb')
  src_files.each { |f| puts f; require f[0...-3] }
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Default: run tests.'
task :default => 'test'
