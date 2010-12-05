module Test
  module Unit
    class TestCase
      include Coulda

      def self.scenarios
        @scenarios ||= []
        @scenarios
      end

      def self.current_scenario=(scenario)
        @current_scenario = scenario
      end

      def self.current_scenario
        @current_scenario
      end

      %w[in_order_to as_a i_want_to].each do |intent|
        eval <<-HERE
          # An intent specifier
          def self.#{intent}(val = nil)
            val ? @#{intent} = val : @#{intent}
          end
        HERE
      end

      %w[Given When Then And].each do |stmt|
        eval <<-HERE
          # Specifies a prereqisite, event, or expectation.  May be used in any order within the spec
          def self.#{stmt}(text, &block)
            step = nil
            if block_given?
              step = block
            end
            caller[0] =~ (/(.*):(.*)(:in)?/)
            stmt = { :type => :#{stmt}, :text => text, :block => step, :file => $1, :line => $2 }
            if text.is_a? Symbol
              stmt[:method] = text
            end
            current_scenario.statements << stmt
          end
        HERE
      end

      def Tag(name)
      end

      # Creates a Scenario instance and adds it to the Feature
      def self.Scenario(scenario_name, &block)
        @scenarios ||=[]
        @scenarios << scenario = Scenario.new(scenario_name, self, &block)
        scenario
      end

      # Raises an error if only some of the intent is captured (i.e., in_order_to and as_a without i_want_to)
      def self.assert_presence_of_intent
        presence = %w[in_order_to as_a i_want_to].map { |intent| instance_variable_get("@#{intent}") }
        if presence.any? { |p| p } && !presence.all? { |p| p }
          raise SyntaxError.new("Must have all or none of in_order, as_a, and i_want_to called in a Feature")
        end
      end
    end
  end
end
