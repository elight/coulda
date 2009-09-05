require 'test/unit'

module Coulda
  class Feature < Test::Unit::TestCase
    class << self
      def in_order_to
        @in_order_to
      end
      def as_a; @as_a; end
      def i_want_to; @i_want_to; end

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
        class_name = name.split(/\s/).map { |w| w.capitalize }.join
        Object.const_set(class_name, klass)
      end

      def assert_description
        if @in_order_to || @as_a || @i_want_to
          raise SyntaxError.new("Must call in_order_to if as_a and/or i_wanted_to called") unless @in_order_to
          raise SyntaxError.new("Must call as_a if in_order_to and/or i_want_to called") unless @as_a
          raise SyntaxError.new("Must call i_want_to if in_order_to and/or as_a called") unless @i_want_to
        end
      end
    end
  end
end
