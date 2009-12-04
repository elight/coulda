require File.join(File.dirname(__FILE__), "..", "test_helper")
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
          Given "something"
          When "the when"
          Then "the then" do
            mock(self).pending
          end
        end
        @@counter += 1
      end
    end

    should "pass" do
      assert(run_feature(@feature_without_errors))
    end
  end
end

