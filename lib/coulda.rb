require 'test/unit'

require File.join(File.dirname(__FILE__), 'coulda', 'world')
require File.join(File.dirname(__FILE__), 'coulda', 'feature')
require File.join(File.dirname(__FILE__), 'coulda', 'scenario')
require File.join(File.dirname(__FILE__), 'coulda', 'pending')
require File.join(File.dirname(__FILE__), 'coulda', 'vendor', 'constantize')
require File.join(File.dirname(__FILE__), 'coulda', 'vendor', 'underscore')
require File.join(File.dirname(__FILE__), 'coulda', 'tasks')

module Coulda
  SyntaxError = Class.new(StandardError)

  def Tag(name)
    @feature_tags ||= []
    @feature_tags << name.to_s
  end

  # Factory method for Test::Unit::TestCase subclasses
  def Feature(name, opts = {}, &block)
    process_command_line_tags

    if @requested_tags && !@requested_tags.empty?
      if @feature_tags.nil? || !@feature_tags.any? { |f_tag| @requested_tags.include? f_tag}
        @feature_tags = nil 
        return
      end
    end
    @feature_tags = nil

    test_class = Class.new(opts[:testcase_class] || Coulda.default_testcase_class || Test::Unit::TestCase)
    World.register_feature(test_class, name)

    Coulda::assign_class_to_const test_class, name
    test_class.class_eval &block if block_given?
    test_class.assert_presence_of_intent


    test_class
  end

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

  def process_command_line_tags
    unless @processed_cmd_line_args
      @processed_cmd_line_args = true
      tags = ARGV.inject([]) { |m, a| m << a if a =~ /^tags=/; m }
      @requested_tags = tags.map { |t| t.split("=")[1].split(",") }.flatten
    end
  end
end

include ::Coulda


