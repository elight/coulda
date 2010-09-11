require "test_helper"

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
end

