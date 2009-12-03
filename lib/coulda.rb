module Coulda
  SyntaxError = Class.new(StandardError)
end

require 'test/unit'

gem 'pending', '>= 0.1.1'
require 'pending'

require 'coulda/world'
require 'coulda/feature'
require 'coulda/scenario'
require 'coulda/vendor/constantize'
require 'coulda/vendor/underscore'

module Kernel
  # Factory method for Test::Unit::TestCase subclasses
  def Feature(name, opts = {}, &block)
    test_class = Class.new(opts[:testcase_class] || Test::Unit::TestCase)
    Coulda::assign_class_to_const test_class, name
    test_class.class_eval &block if block_given?
    test_class.assert_presence_of_intent
    test_class
  end
end

module Coulda
  def assign_class_to_const(test_class, potential_const)
    base_name = potential_const
    if potential_const !~ /^[a-zA-Z]/
      base_name = "a_" + base_name
    end
    titleized_underscored_name = base_name.super_custom_underscore.gsub(/\b('?[a-z])/) { $1.upcase }
    Object.const_set(titleized_underscored_name, test_class)
  end
end

include ::Coulda
