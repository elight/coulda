require 'rake'

Gem::Specification.new do |s|
  s.name = "coulda"
  s.version = "0.1.1"
  s.date = "2009-09-12"
  s.authors = ["Evan David Light"]
  s.email = "evan@tiggerpalace.com"
  s.summary = "Behaviour Driven Development derived from Cucumber but as an internal DSL with methods for reuse"
  s.homepage = "http://evan.tiggerpalace.com/"
  s.description = "Behaviour Driven Development derived from Cucumber but as an internal DSL with methods for reuse"
  s.add_dependency 'jeremymcanally-pending', '>= 0.1'
  s.files = [ 
    "README.rdoc", 
    "LICENSE", 
    "HISTORY",
    "lib/coulda.rb",
    "lib/coulda/scenario.rb",
    "lib/coulda/feature.rb"
  ]
  s.test_files = [
    "test/test_helper.rb",
    "test/feature_test.rb",
    "test/scenario_test.rb"
  ]
end

