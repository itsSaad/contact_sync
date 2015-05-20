require 'rails/generators/active_record'

class InstallContactSyncGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.next_migration_number(path)
    ActiveRecord::Generators::Base.next_migration_number(path)
  end

  source_root File.expand_path('../templates', __FILE__)

  def  generate_migration
    binding.pry
    if !self.class.migration_exists?('db/migrate', 'create_contact_sync_schema')
      migration_template "create_contact_sync_schema.rb", "db/migrate/create_contact_sync_schema.rb"
    end
  end

  def generate_encrypted_strings_config
    inject_into_file 'config/environments/development.rb', before: "end\n" do <<-'RUBY'

  EncryptedStrings::SymmetricCipher.default_algorithm = 'aes-256-cbc'
  EncryptedStrings::SymmetricCipher.default_password = 'Replace This with some long alphanumeric string'

  RUBY
    end
  end

  def generate_models
    template "address.rb",  'app/models/address.rb'
    template 'email.rb',    'app/models/email.rb'
    template 'phone.rb',    'app/models/phone.rb'
    template 'user.rb',     'app/models/user.rb'
    template 'contact.rb',  'app/models/contact.rb'
  end
end
