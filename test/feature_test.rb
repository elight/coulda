require File.join(File.dirname(__FILE__), "test_helper")

class FeatureTest < Test::Unit::TestCase
  def run_feature(feature)
    if Object::RUBY_VERSION =~ /^1.9/
      result = MiniTest::Unit.autorun
    else 
      # Assume 1.8.x
      result = Test::Unit::TestResult.new
      p = Proc.new {}
      feature.suite.run(result, &p)
    end
    result
  end

  context "A Feature class" do
    should "have Test::Unit::TestCase as an ancestor" do
      assert(Feature.ancestors.include?(Test::Unit::TestCase))
    end

    context "created by name" do
      setup do 
        @feature = Feature.for_name "foo"
      end

      should "be a subclass of Feature" do
        assert(@feature.ancestors.include?(Feature))
      end
    end


    context "that calls in_order_to, as_a, and i_want_to" do
      should "not raise syntax error" do
        assert_nothing_raised do 
          Feature "one" do
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
          Feature "two" do
            as_a "bar"
            i_want_to "blech"
          end
        end
      end
    end

    context "that calls in_order_to and i_want_to" do
      should "raise syntax error because as_a was not called once" do
        assert_raise Coulda::SyntaxError do
          Feature "three" do
            in_order_to "foo"
            i_want_to "blech"
          end
        end
      end
    end

    context "that calls in_order_to and as_a" do
      should "raise syntax error because i_want_to was not called once" do
        assert_raise Coulda::SyntaxError do
          Feature "four" do
            in_order_to "foo"
            as_a "bar"
          end
        end
      end
    end

    context "without scenarios" do
      setup do
        @feature_without_scenarios = Feature "five" do
          in_order_to "foo"
          as_a "bar"
          i_want_to "blech"
        end
      end

      should "not have any errors when run" do
        result = run_feature @feature_without_scenarios
        Object::RUBY_VERSION =~ /^1.9/ ?  assert(result.inspect) : assert(result)
      end
    end

    context "that does not have any errors" do
      @@counter = 1
      setup do
        @feature_without_errors = Feature @@counter.to_s do
          in_order_to "foo"
          as_a "bar"
          i_want_to "blech"
        end
        @@counter += 1
      end

      ### Integration tests

      context "with a block containing a scenario" do
        should "create a Feature instance method named 'test_<underscored_scenario_name>'" do
          @feature_without_errors.Scenario "pending scenario"
          test_name = "test_pending_scenario"
          test_name = :test_pending_scenario if RUBY_VERSION =~ /^1.9/
          assert(@feature_without_errors.instance_methods.include?(test_name), "Feature is missing test method from scenario")
        end

        should "create a Scenario" do
          @feature_without_errors.Scenario "pending scenario"
        end

        should "include the created Scenario in the return value of the 'scenarios' method" do
          scenario = @feature_without_errors.Scenario "pending scenario"
          assert(@feature_without_errors.scenarios.include?(scenario), "feature.scenarios doesn't contain the expected Scenario object")
        end
      end
    end
  end
end
