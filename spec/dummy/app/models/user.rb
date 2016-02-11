class User < ActiveRecord::Base
  acts_as_syncable
  has_many :contacts
end
