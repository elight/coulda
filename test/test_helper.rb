require 'test/unit'
require 'rubygems'
require 'shoulda'

test_files_pattern = 'test/**/*_test.rb'
src_files_pattern = 'lib/**/*.rb'
src_files = Dir[src_files_pattern]
src_files.each { |f| puts f; require f[0...-3] }

include Coulda
