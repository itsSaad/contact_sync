require "contact_sync/engine"
require 'contact_sync/util/api_constraints'
require 'contact_sync/util/string_phone'
require 'contact_sync/util/global_phone'
require 'contact_sync/acts_as_syncable'
require 'contact_sync/syncable'
require 'encrypted_strings'
require 'pry-rails'

module ContactSync
end

ActiveRecord::Base.send :extend, ContactSync::ActsAsSyncable
