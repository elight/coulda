namespace :coulda do
  desc "Print all features as plain text"
  task :print_features do

    $LOAD_PATH.unshift("test")

    require 'test/unit'

    # bug in test unit.  Set to true to stop from running.
    Test::Unit.run = true

    test_files = Dir.glob(File.join('test', '**', '*_feature.rb'))
    test_files.each do |file|
      load file
    end

    ObjectSpace.each_object do |obj|
      next unless obj.is_a? Feature

      puts "Feature: #{obj.name}"
      puts "  In order to #{obj.in_order_to}" if obj.in_order_to
      puts "  As a #{obj.as_a}" if obj.as_a
      puts "  I want to #{obj.i_want_to}" if obj.i_want_to
      obj.scenarios.each do |scenario|
        puts
        puts "  Scenario: #{scenario.name} #{scenario.pending? ? '(pending)' : ''}"
        scenario.statements.each do |stmt|
          puts "    #{stmt[:type].to_s} #{stmt[:text]}"
        end
      end
    end
  end
end
