module Test
  module Unit
    class TestCase
      @@pending_cases = []
      @@at_exit = false

      # Loosely based upon Jeremy McAnally's pending
      
      def coulda_pending(txt)
        print "P"
        @@pending_cases << txt
        
        @@at_exit ||= begin
          at_exit do
            puts "\nPending Cases:"
            @@pending_cases.each do |msg|
              puts msg
            end
          end
        end
      end
    end
  end
end

