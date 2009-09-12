require 'rubygems'
require 'coulda'
include Coulda

Feature "feature name" do
  in_order_to "foo"
  as_a "bar"
  i_want_to "blech"

  def something
  end

  def expectation
  end

  Scenario "pending scenario"

  Scenario "another scenario" do
    Given "a pending prereq"
    When "something happens" do
      something
    end
    Then "expect something else" do
      expectation
    end
  end

  Scenario "that is live" do
    Given "foo" do; end
    When "bar" do; end
    Then "blech" do; end
  end
end
