require File.join(File.dirname(__FILE__), "..", "test_helper")

require 'rr'

module GivenSomething
  def given_something
    Given "something" do; end
  end
end

# http://github.com/elight/coulda/issues#issue/1
class Issue1Test < Test::Unit::TestCase
  include RR::Adapters::TestUnit

  context "A Feature that has a Scenario that invokes a 'Given/When/Then' called from a method" do
    setup do
      stub(self).pending { raise Exception.new }

      @feature_without_errors = Feature "Issue 1 feature" do
        extend GivenSomething

        in_order_to "foo"
        as_a "bar"
        i_want_to "blech"

        Scenario "my scenario" do
          given_something
          When "the when" do; end
          Then "the then" do; end
        end
      end
    end

    should "pass" do
      assert(run_feature(@feature_without_errors))
    end
  end
end

