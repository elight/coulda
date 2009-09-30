require 'rubygems'
require 'coulda'
include Coulda

Feature "A pending feature" do
  in_order_to "accomplsih something else"
  as_a "user"
  i_want_to "do something"

  Scenario "that is pending"
end


