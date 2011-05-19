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
        Scenario "ohai" do
          Given "" do; end
          Then "" do; end
        end
      end
      @@counter += 1
    end

    should "be a Test::Unit::TestCase by default" do
      assert @feature.ancestors.include? Test::Unit::TestCase
    end

    should "have a method test_ohai" do
      assert @feature.instance_methods.include? :test_ohai
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
  end
end
