require File.join(File.dirname(__FILE__), "test_helper")

class ScenarioTest < Test::Unit::TestCase
  context "A Scenario" do
    should "have a method called 'given'" do
    end
    should "have a method called 'then'"
    should "have a method called 'when'"

    context "when instantiated" do
      should "not raise an error when given a String" 
      should "raise an error if not given a String"
    end

    context "without a block" do
      should "create a test that outputs that the scenario is pending"
    end

    context "with a block" do
      should "create a test that calls the block"

      context "when calling the block" do
        %[given when then].each do |stmt|
          context "and no #{stmt}s are present" do
            should "raise a DSL syntax error that a #{stmt} is not present"
          end
        end

        context "and all givens occur before all whens" do
          context "and all whens occur before all thens" do
            should "not raise an error"
          end

          context "and all whens do not occur before all thens" do
            should "raise a DSL syntax error"
          end
        end

        context "where not all givens occur before all whens" do
          context "and all whens occur before all thens" do
            should "raise a DSL syntax error"
          end

          context "and all whens do not occur before all thens" do
            should "raise a DSL syntax error"
          end
        end

        context "where givens, whens, are present and in the correct order" do
          %w[given when then].each do |stmt|
            context "but a #{stmt} does not have a block" do
              should "declare the scenario pending"
            end
          end
        end
      end
    end
  end
end

