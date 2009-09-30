require 'rubygems'
require 'coulda'
include Coulda

module MyMacros
  def given_something_without_a_value
    Given "something without a value" do
      @no_value = nil
    end
  end

  def assert_variable_has_a_value
    assert(@no_value)
  end
end

Feature "Painfully obvious" do
  include MyMacros

  in_order_to "demonstrate a simple test"
  as_a "coulda developer"
  i_want_to "provide a straight-forward scenario"


  Scenario "Describing something obvious" do
    given_something_without_a_value

    When "I give it a value" do
      @no_value = true
    end

    Then "it should have a value" do
      assert_variable_has_a_value
    end
  end
end


