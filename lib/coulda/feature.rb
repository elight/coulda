module Coulda
  class Feature
    include Test::Unit::Assertions

    attr_reader :scenarios, :name
    attr_accessor :current_scenario

    def initialize(name)
      @name = name
      @scenarios = []
    end

    %w[in_order_to as_a i_want_to].each do |intent|
      eval <<-HERE
        def #{intent}(val)
          @#{intent} = val
        end
      HERE
    end

    %w[Given When Then And].each do |stmt|
      eval <<-HERE
        def #{stmt}(text, &block)
          @current_scenario.statements << text
          @current_scenario.steps << block if block
        end
      HERE
    end

    def Scenario(scenario_name, &block)
      @scenarios << scenario = Scenario.new(scenario_name, self, &block)
      block.bind(self) if block
      scenario
    end

    def tests
      @scenarios.collect { |s| s.test_class }
    end

    def assert_presence_of_intent
      presence = %w[in_order_to as_a i_want_to].map { |intent| instance_variable_get("@#{intent}") }
      if presence.any? { |p| p } && !presence.all? { |p| p }
        raise SyntaxError.new("Must have all or none of in_order, as_a, and i_want_to called in a Feature")
      end
    end
  end
end
