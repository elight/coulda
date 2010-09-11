require 'test_helper'
require 'rr'

# http://github.com/elight/coulda/issues#issue/1
class PendingScenariosTest < Test::Unit::TestCase
  include RR::Adapters::TestUnit

  context "A Scenario that has at least one pending step" do
    @@counter = 0
    setup do
      @scenario = nil
      @feature_without_errors = Feature "with a pending scenario step #{@@counter}" do
        include RR::Adapters::TestUnit

        @scenario = Scenario "my scenario" do
          Given "this scenario that will call #pending because it has a pending step" do
            mock(self).pending
          end
          When "I have this pending step"
          Then "the test should pass anyway because I mocked pending"
        end
        @@counter += 1
      end
    end

    should "pass" do
      assert(run_feature(@feature_without_errors))
    end
  end
end

