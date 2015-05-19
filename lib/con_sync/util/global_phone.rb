require 'global_phone'
puts "\n\n\n\n\n\n\n\n\n\n\n#{ConSync::Engine.root}\n\n\n\n\n\n\n\n"
GlobalPhone.db_path = ConSync::Engine.root.join('db/global_phone.json')
