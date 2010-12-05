require "test_helper"
require "open3"

Feature "Running only Features and Scenarios with a specific tag" do
  in_order_to "focus on a subset of a problem"
  as_a "developer using coulda"
  i_want_to "run only the Scenarios that are relevant to the problem at hand"

  Scenario "Tagged Feature" do
    When "I execute Coulda requesting only a tagged feature run" do
      @error = `cd tag_test; rake 'coulda:tagged_tests[tagged_feature]'`
    end

    Then "I should only execute the Scenarios in that tagged Feature" do
      # I'm forcing all of the executed scenarios to fail so I can just check the output
      assert_equal 1, @error.scan(/RuntimeError/).count
      assert_equal 1, @error.scan(/Test_tagged_feature/).count
    end
  end

  Scenario "Tagged Scenarios" do
    When "I execute Coulda requesting only a tagged feature run" do
      @error = `cd tag_test; rake 'coulda:tagged_tests[tagged_scenario]'`
    end

    Then "I should only execute the Scenarios matching that tag" do
      assert_equal 2, @error.scan(/RuntimeError/).count
      assert_equal 2, @error.scan(/Test_tagged_scenario/).count
    end
  end

  Scenario "Tagged Scenarios should inherit tags from their container tagged Feature" do
    When "I execute Coulda requesting only a tagged feature run" do
      @error = `cd tag_test; rake 'coulda:tagged_tests[tagged_feature_with_tagged_scenarios]'`
    end

    Then "I should only execute the Scenarios matching that Feature's tag" do
      assert_equal 3, @error.scan(/RuntimeError/).count
      assert_equal 3, @error.scan(/Test_tagged_feature_with_tagged_scenarios/).count
    end
  end
end
