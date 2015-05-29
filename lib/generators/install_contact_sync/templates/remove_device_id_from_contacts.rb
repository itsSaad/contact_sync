class RemoveDeviceIdFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :device_id, :string, default: ""
    remove_index :contacts, name: "unique_device_contact"
    add_index :contacts, [:user_id, :record_id], unique: true
  end
end
