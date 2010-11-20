module Coulda
  SyntaxError = Class.new(StandardError)
end

require 'test/unit'

require 'coulda/world'
require 'coulda/feature'
require 'coulda/scenario'
require 'coulda/pending'
require 'coulda/vendor/constantize'
require 'coulda/vendor/underscore'
require 'coulda/tasks'

module Kernel
  # Factory method for Test::Unit::TestCase subclasses
  def Feature(name, opts = {}, &block)
    test_class = Class.new(opts[:testcase_class] || Coulda.default_testcase_class || Test::Unit::TestCase)
    Coulda::assign_class_to_const test_class, name
    test_class.class_eval &block if block_given?
    test_class.assert_presence_of_intent
    World.register_feature(test_class, name)
    test_class
  end
end

module Coulda
  def self.default_testcase_class=(klass)
    unless klass.is_a?(Class) && klass.ancestors.include?(Test::Unit::TestCase)
      raise Exception, "Can only provide a Test::Unit::TestCase"
    end
    @class = klass
  end

  def self.default_testcase_class
    @class
  end

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
