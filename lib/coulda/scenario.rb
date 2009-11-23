module Coulda
  # A factory for Test::Unit::TestCases (or their subclass).
  class Scenario
    attr_reader :name, :test_class
    attr_accessor :steps, :statements

    # Class-level method to set the subclass of Test::Unit::TestCase to use as the parent for 
    # tests manufactured by Scenarios.
    def self.testcase_class=(klass)
      unless klass.ancestors.include?(Test::Unit::TestCase)
        raise Exception.new("class must inherit from Test::Unit:TestCase") 
      end
      @testcase_class = klass
    end

    def initialize(name, my_feature, &block)
      @name = name
      @statements = []
      @steps = []
      @pending = false
      @test_class = Class.new(Test::Unit::TestCase)
      if block
        execute block, :within => my_feature
        inject_test_steps_into @test_class
        define_test_method { self.class.test_steps.each { |s| my_feature.instance_eval &s } }
      else
        @pending = true
        define_test_method { pending }
      end
    end

    # Predicate indicating if the Scenario was provided with an example
    def pending?
      @pending
    end
    
    private

    def define_test_method(&block)
      @test_class.send(:define_method, "test_#{@name.downcase.super_custom_underscore}", &block)
    end

    def execute(block, params = {})
      feature = params[:within]
      feature.current_scenario = self
      feature.instance_eval &block
    end

    def inject_test_steps_into(test_class)
      class << test_class
        attr_accessor :test_steps
      end
      test_class.test_steps = @steps
    end
  end
end
