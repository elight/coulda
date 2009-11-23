require File.join(File.dirname(__FILE__), "test_helper")

class ScenarioTest < Test::Unit::TestCase
  context "A Scenario" do
    setup do
      @scenario = Scenario.new("foobar", Feature("something_or_other")) {}
    end

    context "when instantiated" do 
      context "with only a String" do
        setup do 
          @scenario = Scenario.new("foobar", Feature("another")) 
        end

        should "be pending" do
          assert(@scenario.pending?)
        end
      end
    end
  end

  should "allow Test::Unit::TestCase class to subclass to be set" do
    Scenario.testcase_class = Test::Unit::TestCase
  end

  should "raise an Exception if provided a class that does not inherit from Test::Unit::TestCase" do
    assert_raises Exception do
      Scenario.testcase_class = Object
    end
  end
end

