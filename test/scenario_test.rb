require File.join(File.dirname(__FILE__), "test_helper")

class ScenarioTest < Test::Unit::TestCase
  context "A Scenario" do
    setup do
      @scenario = Scenario.new("foobar")
    end

    %w[Given When Then].each do |condition|
      should "have a method called '#{condition}'" do
        assert(@scenario.respond_to?(condition.to_sym))
      end
    end

    context "when instantiated" do 
      context "with only a String" do
        setup do 
          @scenario = Scenario.new("foobar")
        end

        should "be pending" do
          assert(@scenario.pending?)
        end
      end
    end
  end
end

