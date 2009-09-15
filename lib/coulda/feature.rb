module Coulda
  class Feature < Test::Unit::TestCase
    class << self
      def in_order_to(what)
        @in_order_to = what
      end

      def as_a(who)
        @as_a = who
      end

      def i_want_to(what)
        @i_want_to = what
      end

      def for_name(name)
        klass = Class.new(Feature)
        class_name = "Feature" + name.split(/\s/).map { |w| w.capitalize }.join
        Object.const_set(class_name, klass)
        klass
      end

      def assert_description
        if @in_order_to || @as_a || @i_want_to
          raise SyntaxError.new("Must call in_order_to if as_a and/or i_wanted_to called") unless @in_order_to
          raise SyntaxError.new("Must call as_a if in_order_to and/or i_want_to called") unless @as_a
          raise SyntaxError.new("Must call i_want_to if in_order_to and/or as_a called") unless @i_want_to
        end
      end

      def Scenario(name, &test_implementation)
        raise SyntaxError.new("A scenario requires a name") unless name
        method_name = "test_#{name.sub(/\s/, "_").downcase}"
        @scenarios ||= []
        @scenarios << scenario = Scenario.new(name, &test_implementation)
        if scenario.pending?
          define_method(method_name) { pending }
        else
          define_method(method_name, &test_implementation)
        end
        scenario
      end

      def scenarios
        @scenarios ||= []
      end

      def pending?
        @scenarios.all? { |s| !s.pending? }
      end
    end

    # Scenario-less features should be pending
    def default_test
      pending
    end
  end

  %w[Given When Then].each do |statement|
    eval <<-HERE
      def #{statement}(name, &block)
        block.call
      end
    HERE
  end
end


