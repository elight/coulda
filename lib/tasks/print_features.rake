require 'rake'

namespace :coulda do
  desc "Print all features as plain text"
  task :print_features do

    $LOAD_PATH.unshift("test")

    require 'test/unit'

    # bug in test unit.  Set to true to stop from running.
    unless RUBY_VERSION =~ /^1.9/
      Test::Unit.run = true
    end


    test_files = Dir.glob(File.join('test', '**', '*_test.rb'))
    test_files.each do |file|
      load file
    end

    Coulda::World.features.each do |name, sexps|
      puts "Feature: #{name}"
      sexps.each do |sexp|
        next if sexp.is_a? String
        case sexp[1]
        when :in_order_to
          puts "  In order to #{sexp[1]}"
        when :as_a
          puts "  As a #{sexp[1]}"
        when :i_want_to 
          puts "  I want to #{sexp[1]}"
        when :Scenario
          puts
          print "  "
          print "(**PENDING**) " if sexp.length < 4 || sexp[3].any? { |s| s.length < 4 }
          puts "Scenario: #{sexp[2]}"
          sexp[3].each do |step|
            print "    "
            print "(**PENDING**) " unless step.length == 4
            puts "#{step[1]} #{step[2]}"
          end
          puts
        end
      end
    end
  end
end
