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

    def self.testcase_class
      @testcase_class
    end

    def initialize(name, my_feature, &block)
      raise Exception.new("Scenario must have a name") unless name 
      @name = name
      @statements = []
      @steps = []
      @pending = false
      @test_class = ::Class.new(Scenario.testcase_class || Test::Unit::TestCase)
      assign_test_class_to_const(my_feature)
      test_impl = nil
      if block
        create_and_provision_test_method_for my_feature, &block
      else
        @pending = true
        define_test_method_using { pending }
      end
    end

    # Predicate indicating if the Scenario was provided with an example
    def pending?
      @pending
    end
    
    private

    def create_and_provision_test_method_for(feature, &block)
      execute block, :within => feature
      inject_test_steps_into @test_class
      define_test_method_using { self.class.test_steps.each { |s| feature.instance_eval &s } }
    end

    def assign_test_class_to_const(my_feature)
      base_name = "#{my_feature.name}_#{@name}_#{rand(1_000_000_000)}"
      base_name = "letter_" + base_name if base_name =~ /^[^a-zA-Z]/
      titleized_underscored_name = base_name.super_custom_underscore.gsub(/\b('?[a-z])/) { $1.upcase }
      ::Module.const_set(titleized_underscored_name, @test_class)
    end

    def define_test_method_using(&block)
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
