require 'pry-rails'
require "contact_sync/engine"
# require 'contact_sync/util/api_constraints'
require 'contact_sync/util/string_phone'
require 'contact_sync/util/global_phone'
require 'contact_sync/acts_as_syncable'
require 'contact_sync/syncable'
require 'encrypted_strings'

module ContactSync
  def location
    return File.dirname(__FILE__)
  end
end

ActiveRecord::Base.send :extend, ContactSync::ActsAsSyncable
