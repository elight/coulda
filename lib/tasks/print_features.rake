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

    Coulda::World.features.each do |name, output|
      puts "Feature: #{name}"
      output.expressions.each do |sexp|
        case sexp.symbol
        when :in_order_to
          puts "  In order to #{sexp.args}"
        when :as_a
          puts "  As a #{sexp.args}"
        when :i_want_to
          puts "  I want to #{sexp.args}"
        when :Scenario
          puts
          print "  "
          print "(**PENDING**) " if sexp.scope.nil? || sexp.scope.expressions.any? { |step| step.proc.nil? }
          puts "Scenario: #{sexp.args}"
          sexp.scope.expressions.each do |step|
            print "    "
            print "(**PENDING**) " unless step.proc
            puts "#{step.symbol} #{step.args}"
          end
          puts
        end
      end
    end
  end
end
