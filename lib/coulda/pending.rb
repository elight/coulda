module Test
  module Unit
    class TestCase
      @@pending_cases = []
      @@at_exit = false

      # Loosely based upon Jeremy McAnally's pending
      
      def pending(scenario, statement)
        @@pending_cases << [scenario, statement]
        print "P"
        
        @@at_exit ||= begin
          at_exit do
            puts "\nPending Cases:"
            @@pending_cases.each do |scenario, stmt|
              puts "#{stmt[:file]}:#{stmt[:line]}: Scenario '#{scenario.name}': #{stmt[:type]} '#{stmt[:text]}'"
            end
          end
        end
      end
    end
  end
end

