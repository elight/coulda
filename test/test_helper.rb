require 'test/unit'
require 'rubygems' if RUBY_VERSION != "1.9.1"
require 'shoulda'

require File.join(File.dirname(__FILE__), '..', 'lib', 'coulda')

include Coulda

def run_feature(feature)
  if Object::RUBY_VERSION =~ /^1.9/
    result = MiniTest::Unit.autorun
  else 
    # Assume 1.8.x
    result = Test::Unit::TestResult.new
    p = Proc.new {}
    feature.suite.run(result, &p)
  end
  result
end
