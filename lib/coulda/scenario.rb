module Coulda
  # A factory for Test::Unit::TestCase test methods
  class Scenario
    attr_reader :name, :test_class
    attr_accessor :statements

    def initialize(name, my_feature, &block)
      raise Exception.new("Scenario must have a name") unless name 
      @name = name
      @statements = []
      @pending = true
      @my_feature = my_feature
      create_and_provision_test_method_using &block
    end

    # Predicate indicating if the Scenario was provided with an example
    def pending?
      @pending
    end
    
    private

    def create_and_provision_test_method_using(&block)
      collect_scenario_statements_from &block
      @pending = false unless has_pending_statements?
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
      if block_given?
        @my_feature.instance_eval &block 
      end
    end

    def define_test_method_using(&block)
      scenario = self
      @my_feature.send(:define_method, "test_#{@name.downcase.super_custom_underscore}") do
        self.class.current_scenario = scenario
        self.instance_eval &block if block
      end
    end

    def has_pending_statements?
      statements.find { |s| s[:block].nil? && s[:method].nil? }
    end
  end
end
