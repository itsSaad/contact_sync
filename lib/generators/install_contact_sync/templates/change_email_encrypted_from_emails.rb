class changeEmailSchema < ActiveRecord::Migration
  def up
    add_column :emails, :encrypted_email, :string
    remove_column :emails, :email
  end

  def down
    remove_column :emails, :encrypted_email
    add_column :emails, :email, :string
  end
end
