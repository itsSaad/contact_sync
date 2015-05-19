require 'global_phone'
puts "\n\n\n\n\n\n\n\n\n\n\n#{ContactSync::Engine.root}\n\n\n\n\n\n\n\n"
GlobalPhone.db_path = ContactSync::Engine.root.join('db/global_phone.json')
