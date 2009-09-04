require File.join(File.dirname(__FILE__), "test_helper")

class FeatureTest < Test::Unit::TestCase
  context "A Feature" do
    should "be a subclass of Test::Unit::TestCase" do
      assert_instance_of(Test::Unit::TestCase, Feature.new("foo"))
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
