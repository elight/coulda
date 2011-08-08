require "test_helper"

require 'rr'

Feature "Using Coulda", :testcase_class => Test::Unit::TestCase do
  include RR::Adapters::TestUnit

  in_order_to "perform lightweight integration/acceptance testing with Coulda"
  as_a "developer"
  i_want_to "have typical Coulda usage work"

  def given_something; end

  Scenario "A pending scenario with a Given/When/Then without a block" do
    Given "this scenario which should be pending" do
      mock(self).coulda_pending(anything).times(1)
    end
    When "an event happens"
    Then "should not error/fail because it is pending" do; end
  end

  Scenario "A live scenario with a call to a class method" do
    given_something
    Then "should pass if the method does not fail/error" do
    end
  end

  Scenario "A scenario with a lot of Ands" do
    Given "no prerequisites" do; end
    And "some more lack of prerequisites" do; end
    When "something doesn't happen" do; end
    And "something else doesn't happen" do; end
    Then "something else" do; end
    And "should pass" do; end
  end
end
