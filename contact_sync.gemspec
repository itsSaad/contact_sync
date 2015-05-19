$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "contact_sync/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "contact_sync"
  s.version     = ContactSync::VERSION
  s.authors     = ["Saad Masood"]
  s.email       = ["me@itssaad.com"]
  s.homepage    = "http://github.com/itsSaad/contacts_sync"
  s.summary     = "Easy Contact Syncing API"
  s.description = "Easy Contacts Syncing over API with encrypted contacts email and phone numbers"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency 'global_phone', '1.0.1'
  s.add_dependency 'encrypted_strings', '0.3.3'


  s.add_development_dependency "sqlite3"
end
