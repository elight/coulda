require 'test_helper'

class FeatureTest < Test::Unit::TestCase

  should "be able to specify a default TestCase class to subclass for all Features" do
    MyTestCase = Class.new(Test::Unit::TestCase)
    Coulda.default_testcase_class = MyTestCase
    feature = Feature "a child class"
    assert feature.ancestors.include? MyTestCase
  end

  should "raise if the default TestCase class is not a Class" do
    assert_raises Exception do
      Coulda.default_testcase_class = "ohai"
    end
  end

  should "be able to subclass any child class of TestCase" do
    MyTestCase2 = Class.new(Test::Unit::TestCase)
    feature = Feature "another child class", :testcase_class => MyTestCase2
    assert feature.ancestors.include? Test::Unit::TestCase
  end

  context "A Feature" do
    @@counter = 1
    setup do
      @feature = Feature "foobarblech#{@@counter}" do
        Scenario "" do
          Given "" do; end
          Then "" do; end
        end
      end
      @@counter += 1
    end

    should "be a Test::Unit::TestCase by default" do
      assert @feature.ancestors.include? Test::Unit::TestCase
    end

    %w[Given When Then And].each do |condition|
      should "have a method called '#{condition}'" do
        assert(@feature.respond_to?(condition))
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

      should "not have any tests" do
        assert @feature_without_scenarios.instance_methods.grep(/^test_/).empty?
      end
    end

    context "that does not have any errors" do
      setup do
        @feature_without_errors = Feature @@counter.to_s do
          in_order_to "foo"
          as_a "bar"
          i_want_to "blech"
        end
      end

      ### Integration tests

      context "with a block containing a scenario" do
        should "create a Feature instance method named 'test_<underscored_feature_name>_<underscored_scenario_name>'" do
          @feature_without_errors.Scenario("pending scenario") {}
          test_name = "test_pending_scenario"
          test_name = test_name.to_sym if RUBY_VERSION =~ /^1.9/
          assert(@feature_without_errors.instance_methods.include?(test_name), "Test is missing test method from scenario")
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
