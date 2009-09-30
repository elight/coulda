require 'rubygems'
require 'coulda'
include Coulda

Feature "Painfully obvious" do
  in_order_to "demonstrate a simple test"
  as_a "coulda developer"
  i_want_to "provide a straight-forward scenario"

  Scenario "Describing something obvious" do
    Given "something without a value" do
      @no_value = nil
    end

    When "I give it a value" do
      @no_value = true
    end

    Then "it should have a value" do
      assert(@no_value)
    end
  end
end


