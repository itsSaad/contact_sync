class Contact < ActiveRecord::Base

  has_many :phones, dependent: :delete_all
  has_many :emails, :dependent => :delete_all

  belongs_to :user
  validates_presence_of :user
  validates :record_id, presence: true, numericality: {:greater_than => 0}

end
