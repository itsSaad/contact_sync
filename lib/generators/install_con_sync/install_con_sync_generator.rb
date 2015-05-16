require 'rails/generators/active_record'

class InstallConSyncGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def  generate_migration
    migration_template "con_sync_generator", "db/migrate/create_con_sync.rb"
  end
end
