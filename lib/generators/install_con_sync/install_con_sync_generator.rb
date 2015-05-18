require 'rails/generators/active_record'

class InstallConSyncGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.next_migration_number(path)
    ActiveRecord::Generators::Base.next_migration_number(path)
  end

  source_root File.expand_path('../templates', __FILE__)

  def  generate_migration
    migration_template "create_con_sync_schema.rb", "db/migrate/create_con_sync.rb"
  end

  def generate_routes
    route(File.read(File.join(File.dirname(__FILE__), 'templates/routes.rb') ))
  end
end
