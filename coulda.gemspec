# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coulda}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Evan David Light"]
  s.date = %q{2009-12-04}
  s.description = %q{Behaviour Driven Development derived from Cucumber but as an internal DSL with methods for reuse}
  s.email = %q{evan@tiggerpalace.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
     "HISTORY",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "coulda.gemspec",
     "example/feature_with_pending_scenario.rb",
     "example/macros_in_a_module.rb",
     "example/pending_feature.rb",
     "example/pending_feature_with_purpose.rb",
     "example/sample.rb",
     "example/simple_reuse_via_method.rb",
     "example/simple_scenario.rb",
     "geminstaller.yml",
     "lib/coulda.rb",
     "lib/coulda/feature.rb",
     "lib/coulda/scenario.rb",
     "lib/coulda/tasks.rb",
     "lib/coulda/pending.rb",
     "lib/coulda/tasks/print_features.rake",
     "lib/coulda/vendor/constantize.rb",
     "lib/coulda/vendor/underscore.rb",
     "lib/coulda/world.rb",
     "test/feature_test.rb",
     "test/integration/using_coulda_test.rb",
     "test/regression/issue_1_test.rb",
     "test/regression/pending_scenarios_test.rb",
     "test/scenario_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://evan.tiggerpalace.com/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Behaviour Driven Development derived from Cucumber but as an internal DSL with methods for reuse}
  s.test_files = [
    "test/feature_test.rb",
     "test/integration/using_coulda_test.rb",
     "test/regression/issue_1_test.rb",
     "test/regression/pending_scenarios_test.rb",
     "test/scenario_test.rb",
     "test/test_helper.rb"
  ]
  s.add_dependency 'pending', '>= 0.1.1'

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

