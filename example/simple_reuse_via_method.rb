require 'rubygems'
require 'coulda'
include Coulda

Feature "Painfully obvious" do
  in_order_to "demonstrate a simple test"
  as_a "coulda developer"
  i_want_to "provide a straight-forward scenario"

  def something_without_a_value
    @no_value = nil
  end

  Scenario "Describing something obvious" do
    Given "something without a value" do
      something_without_a_value
    end

    When "I give it a value" do
      @no_value = true
    end

    Then "it should have a value" do
      assert(@no_value)
    end
  end
end


