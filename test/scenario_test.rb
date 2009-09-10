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

      context "with a block" do
        context "when validating the semantics of the code in the block" do
          should "raise a DSL syntax error if no givens are present" do
            assert_raises Coulda::SyntaxError do
              Scenario.new "foo" do
                When "bar"
                Then "blech"
              end
            end
          end

          should "raise a DSL syntax error if no whens are present" do
            assert_raises Coulda::SyntaxError do
              Scenario.new "foo" do
                Given "bar"
                Then "blech"
              end
            end
          end

          should "raise a DSL syntax error if no thens are present" do
            assert_raises Coulda::SyntaxError do
              Scenario.new "foo" do
                Given "bar"
                When "blech"
              end
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
            %w[Given When Then].each do |stmt|
              context "but a #{stmt} does not have a block" do
                should "declare the scenario pending"
              end

              context "and the givens, whens, and thens have blocks" do
                should "not be pending"
              end
            end
          end
        end
      end
    end
  end
end

