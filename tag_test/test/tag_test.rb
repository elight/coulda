require 'test_helper'

Tag :tagged_feature
Feature "Test tagged feature" do
  Scenario "tagged_feature scenario" do
    When "I raise" do
      raise
    end
  end
end

Feature "Test tagged scenarios" do
  2.times do |i|
    Tag :tagged_scenario
    Scenario "tagged_scenario #{i}" do
      When "I raise" do
        raise
      end
    end
  end

  Scenario "untagged" do
    When "I raise" do
      raise
    end
  end
end

Tag :tagged_feature_with_tagged_scenarios
Feature "Test tagged feature with differently tagged scenarios" do
  3.times do |i|
    Tag :junk_tag
    Scenario "tagged_feature_with_tagged_scenarios #{i}" do
      When "I raise" do
        raise
      end
    end
  end
end
