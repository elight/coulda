module Coulda
  # A factory for Test::Unit::TestCase test methods
  class Scenario
    attr_reader :name, :test_class
    attr_accessor :steps, :statements

    def initialize(name, my_feature, &block)
      raise Exception.new("Scenario must have a name") unless name 
      @name = name
      @statements = []
      @steps = []
      @pending = false
      @my_feature = my_feature
      if block_given?
        create_and_provision_test_method_using &block
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

    def create_and_provision_test_method_using(&block)
      collect_scenario_statements_from &block
      define_test_method_using do
        self.class.current_scenario.statements.each do |stmt|
          if stmt[:block]
            self.instance_eval &(stmt[:block])
          else
            pending self.class.current_scenario, stmt
            break
          end
        end
      end
    end

    def collect_scenario_statements_from(&block)
      @my_feature.current_scenario = self
      @my_feature.instance_eval &block
    end

    def define_test_method_using(&block)
      scenario = self
      @my_feature.send(:define_method, "test_#{@name.downcase.super_custom_underscore}") do
        self.class.current_scenario = scenario
        self.instance_eval &block
      end
    end
  end
end
