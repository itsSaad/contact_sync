class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :composite_name
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :prefix
      t.string :suffix
      t.string :nickname
      t.string :organization
      t.string :job_title
      t.string :department
      t.date :birthdate
      t.text :note
      t.string :device_id
      t.integer :record_id, default: 0
      t.datetime :creation_date
      t.datetime :modification_date
      t.integer :user_id
      t.timestamps
    end

    create_table :phones do |t|
      t.string :label
      t.string :encrypted_number
      t.string :cc_prefix
      t.string :extension
      t.integer :contact_id

      t.timestamps
    end

    create_table :emails do |t|
      t.string :label
      t.string :encrypted_email
      t.integer :contact_id

      t.timestamps
    end


    add_column :users, :last_contact_sync, :datetime
    add_column :users, :encrypted_number, :string
    add_column :users, :cc_prefix, :string
    add_index :users, :encrypted_number

    add_index :contacts, [:record_id, :device_id], name: "unique_device_contact", unique: true
    add_index :contacts, :user_id
    add_index :phones, :encrypted_number
    add_index :emails, :encrypted_email

  end
end
