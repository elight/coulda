module Coulda
  # The Feature class is composed of an intent and a series of zero or more Scenarios that describe the behavior
  # that satisfies the intent.  Capturing intent is a key feature of Coulda.  Intent defines the business value 
  # the Feature is attempting to fulfill.  It serves as a reminder for developers (and customers) as to why this
  # Feature was implemented and why this spec was written.
  class Feature
    include Test::Unit::Assertions

    attr_reader :scenarios, :name
    attr_accessor :current_scenario

    def initialize(name, opts = {})
      @name = name
      @scenarios = []
      Scenario.testcase_class = opts[:testcase_class] if opts[:testcase_class]
    end

    %w[in_order_to as_a i_want_to].each do |intent|
      eval <<-HERE
        # An intent specifier
        def #{intent}(val = nil)
          val ? @#{intent} = val : @#{intent}
        end
      HERE
    end

    %w[Given When Then And].each do |stmt|
      eval <<-HERE
        # Specifies a prereqisite, event, or expectation.  May be used in any order within the spec
        def #{stmt}(text, &block)
          @current_scenario.statements << { :type => :#{stmt}, :text => text }
          @current_scenario.steps << block if block
        end
      HERE
    end

    # Creates a Scenario instance and adds it to the Feature
    def Scenario(scenario_name, &block)
      @scenarios << scenario = Scenario.new(scenario_name, self, &block)
      scenario
    end

    # Accessor to the Scenario-created TestCases
    def tests
      @scenarios.collect { |s| s.test_class }
    end


    # Raises an error if only some of the intent is captured (i.e., in_order_to and as_a without i_want_to)
    def assert_presence_of_intent
      presence = %w[in_order_to as_a i_want_to].map { |intent| instance_variable_get("@#{intent}") }
      if presence.any? { |p| p } && !presence.all? { |p| p }
        raise SyntaxError.new("Must have all or none of in_order, as_a, and i_want_to called in a Feature")
      end
    end
  end
end
