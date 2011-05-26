require 'test/unit'
require 'lispy'

require File.join(File.dirname(__FILE__), 'coulda', 'world')
require File.join(File.dirname(__FILE__), 'coulda', 'pending')
require File.join(File.dirname(__FILE__), 'coulda', 'vendor', 'constantize')
require File.join(File.dirname(__FILE__), 'coulda', 'vendor', 'underscore')
require File.join(File.dirname(__FILE__), 'coulda', 'tasks')

module Coulda
  PROC_KEYWORDS = [:Given, :When, :Then, :And]
  KEYWORDS = [:Scenario, :Tag, :in_order_to, :as_a, :i_want_to] + PROC_KEYWORDS

  SyntaxError = Class.new(StandardError)

  # Factory method for Test::Unit::TestCase subclasses
  def Feature(name, opts = {}, &block)
    test_class = Class.new(opts[:testcase_class] || Coulda.default_testcase_class || Test::Unit::TestCase)

    assign_class_to_const test_class, name
    test_class.instance_eval do
      extend Lispy
      acts_lispy :only => Coulda::KEYWORDS, :retain_blocks_for => Coulda::PROC_KEYWORDS
    end
    test_class.class_eval &block if block_given?

    World.register_feature(name, test_class.output)

    generate_test_methods_from test_class

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

  private

  def assign_class_to_const(test_class, potential_const)
    base_name = potential_const
    if potential_const !~ /^[a-zA-Z]/
      base_name = "a_" + base_name
    end
    titleized_underscored_name = base_name.super_custom_underscore.gsub(/\b('?[a-z])/) { $1.upcase }
    Object.const_set(titleized_underscored_name, test_class)
  end

  def generate_test_methods_from(test_class)
    return unless test_class.output && test_class.output.expressions

    test_class.output.expressions.each do |sexp|
      next unless sexp.symbol == :Scenario
      generate_test_method :for_scenario => sexp, :in_class => test_class
    end
  end

  def generate_test_method(args = {})
    scenario, test_class = args[:for_scenario], args[:in_class]
    file_name = test_class.output.file

    test_class.send(:define_method,"test_#{scenario.args.downcase.super_custom_underscore}") do
      if scenario.scope.nil?
        coulda_pending "Scenario '#{scenario.args}' in #{file_name}:#{scenario.lineno}"
      else
        execute_test_steps :for_scenario => scenario, :in_class => test_class
      end
    end
  end

  def execute_test_steps(args = {})
    scenario, test_class = args[:for_scenario], args[:in_class]
    file_name = test_class.output.file

    scenario.scope.expressions.each do |step_sexp|
      if step_sexp.proc.nil?
        coulda_pending "Scenario '#{scenario.args}': #{step_sexp.symbol} '#{step_sexp.args} in #{file_name}:#{step_sexp.lineno}"
      else
        instance_eval &step_sexp.proc
      end
    end
  end
end

include ::Coulda
