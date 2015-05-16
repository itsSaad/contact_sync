require 'rails/generators/active_record'

class InstallConSync < Rails::Generators::Base
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def  generate_migration
    migration_template "create_con_sync_schema", "db/migrate/create_con_sync.rb"
  end
end
