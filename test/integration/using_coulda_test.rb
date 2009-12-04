require File.join(File.dirname(__FILE__), "..", "test_helper")

require 'rr'

Feature "Using Coulda", :testcase_class => Test::Unit::TestCase do
  include RR::Adapters::TestUnit

  in_order_to "perform lightweight integration/acceptance testing with Coulda"
  as_a "developer"
  i_want_to "have typical Coulda usage work"

  def prove_methods_from_then_invokes_method_on_feature
    assert true
  end

  Scenario "A pending scenario with a Given/When/Then without a block" do
    Given "this scenario which should be pending" do
      mock(self).pending.times(1)
    end
    When "an event happens"
    Then "should not error/fail because it is pending" do; end
  end

  Scenario "A scenario without a When" do
    Given "a scenario calling a Feature instance method" do; end
    Then "should pass if the method does not fail/error" do
      prove_methods_from_then_invokes_method_on_feature
    end
  end

  Scenario "that is live" do
    Given "no prerequisites" do; end
    When "no events" do; end
    Then "should pass" do; end
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
