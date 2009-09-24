namespace :coulda do
  desc "Print all features as plain text"
  task :print_features do

    require 'rubygems'
    #require 'active_support'

    def file_name_to_feature(name)
      name =~ /\/([\w\s_]+)\.rb$/
      file_prefix = $1
      file_prefix.gsub!(/[Tt]est/,"")
      klass_name = Feature.feature_name_from(file_prefix)
      Object.const_defined?(klass_name) ? klass_name.constantize : nil
    end

    $LOAD_PATH.unshift("test")

    require 'test/unit'

    # bug in test unit.  Set to true to stop from running.
    Test::Unit.run = true

    test_files = Dir.glob(File.join('test', '**', '*_test.rb'))
    test_files.each do |file|
      load file
      File.basename(file, '.rb')
      feature = file_name_to_feature(file)
      next unless feature

      next unless feature.ancestors.include?(Feature)

      puts "Feature: #{feature.description}"
      puts "  In order to #{feature.in_order_to}"
      puts "  As a #{feature.as_a}"
      puts "  I want to #{feature.i_want_to}"
      feature.scenarios.each do |scenario|
        puts
        puts "  Scenario: #{scenario.name} #{scenario.pending? ? '(pending)' : ''}"
        scenario.statements.each do |stmt|
          puts "    #{stmt.type.to_s.capitalize} #{stmt.name}"
        end
      end
    end
  end
end
