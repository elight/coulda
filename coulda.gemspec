require 'rake'

Gem::Specification.new do |s|
  s.name = %q{coulda}
  s.version = "0.1.0"
  s.date = %q{2009-09-11}
  s.authors = ["Evan Light"]
  s.email = %q{evan@tiggerpalace.com}
  s.summary = %q{Behaviour Driven Development with less tooling instead of more}
  s.homepage = %q{http://evan.tiggerpalace.com/}
  s.description = %q{Behaviour Driven Development with less tooling instead of more}
  s.description = %q{ParseConfig provides simple parsing of standard *nix style config files.}
  s.files = [ "README.rdoc", "LICENSE", Array(FileList.new("lib/**/**")), Array(FileList.new("test/**"))].flatten
  s.add_dependency 'jeremymcanally-pending', '>= 0.1'
end

