require File.join(File.dirname(__FILE__), "test_helper")

class FeatureTest < Test::Unit::TestCase
  context "A Feature class" do
    should "have Test::Unit::TestCase as an ancestor" do
      assert(Feature.ancestors.include? Test::Unit::TestCase)
    end

    context "created by name" do
      setup do 
        @feature = Feature.for_name "foo"
      end

      should "be a subclass of Feature" do
        assert(@feature.ancestors.include? Feature)
      end
    end


    context "that calls in_order_to, as_a, and i_want_to" do
      should "not raise syntax error" do
        assert_nothing_raised do 
          feature "one" do
            in_order_to "foo"
            as_a "bar"
            i_want_to "blech"
          end
        end
      end
    end

    context "that calls as_a and i_want_to" do
      should "raise syntax error because in_order_to was not called once" do
        assert_raise Coulda::SyntaxError do 
          feature "two" do
            as_a "bar"
            i_want_to "blech"
          end
        end
      end
    end

    context "that calls in_order_to and i_want_to" do
      should "raise syntax error because as_a was not called once" do
        assert_raise Coulda::SyntaxError do
          feature "three" do
            in_order_to "foo"
            i_want_to "blech"
          end
        end
      end
    end

    context "that calls in_order_to and as_a" do
      should "raise syntax error because i_want_to was not called once" do
        assert_raise Coulda::SyntaxError do
          feature "four" do
            in_order_to "foo"
            as_a "bar"
          end
        end
      end
    end

    context "without scenarios" do
      context "when loaded" do
        should "not have any errors"
      end
    end

    context "with scenarios" do
      context "when loaded" do
        should "create a method named 'test_<underscored_scenario_name>' method for each scenario"
      end
    end
  end
end
