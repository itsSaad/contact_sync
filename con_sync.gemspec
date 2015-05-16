$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "con_sync/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "con_sync"
  s.version     = ConSync::VERSION
  s.authors     = ["Saad Masood"]
  s.email       = ["me@itssaad.com"]
  s.homepage    = "http://github.com/itsSaad/c_sync"
  s.summary     = "Summary of ConSync."
  s.description = "Description of ConSync."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
