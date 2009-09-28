module Coulda
  Statement = Struct.new(:type, :name, :block)

  module FeatureBehavior
    %w[Given When Then].each do |statement|
      eval <<-HERE
        def #{statement}(name, &block)
          @pending = true unless block_given?
          @statements << stmt = Statement.new(:#{statement}, name, block)
        end
      HERE
    end
  end

  class Feature < Test::Unit::TestCase
    class << self
      attr_accessor :description
      attr_reader :in_order_to, :as_a, :i_want_to

      def include(*args)
        super *args
        extend *args
      end

      [:in_order_to, :as_a, :i_want_to].each do |field|
        eval <<-HERE
          def #{field}(arg = nil)
            if arg
              @#{field} = arg
            else
              @#{field}
            end
          end
        HERE
      end

      def for_name(name)
        klass = Class.new(Feature)
        klass.extend(FeatureBehavior)
        klass.description = name
        class_name = feature_name_from(name)
        Object.const_set(class_name, klass)
        klass
      end

      def feature_name_from(name)
        "Feature" + name.split(/\s|_/).map { |w| w.capitalize }.join
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
        create_test_method_for(name, &test_implementation)
        create_scenario_for(name, &test_implementation)
      end

      def scenarios
        @scenarios ||= []
      end

      def pending?
        @scenarios.all? { |s| !s.pending? }
      end

      private

      def create_test_method_for(name, &test_implementation)
        method_name = "test_#{name.sub(/\s+/, "_").downcase}"
        @scenarios ||= []
        if block_given?
          define_method(method_name, &test_implementation)
        else
          define_method(method_name) { pending }
        end
      end

      def create_scenario_for(name, &test_implementation)
        @scenarios ||= []
        scenario = nil
        if block_given?
          scenario = Scenario.new(name, &test_implementation)
          scenario.statements = extract_statements_from &test_implementation
        else
          scenario = Scenario.new(name)
        end
        @scenarios << scenario
        scenario
      end

      def extract_statements_from(&test_implementation)
        @statements ||= []
        self.instance_eval(&test_implementation)
        statements = @statements
        @statements = []
        statements
      end
    end

    # Scenario-less features should be pending
    def default_test
      pending
    end

    %w[Given When Then].each do |statement|
      eval <<-HERE
        def #{statement}(name, &block)
          yield if block_given?
        end
      HERE
    end
  end
end
