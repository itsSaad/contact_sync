class Contact < ActiveRecord::Base

  has_many :phones, dependent: :delete_all
  has_many :emails, :dependent => :delete_all
  # has_many :addresses, :dependent => :delete_all
  # has_many :instant_messengers, :dependent => :delete_all
  # has_many :social_profiles, :dependent => :delete_all

  belongs_to :user

  # def jsonNotation
  #
  #   phonesJSON = Array.new
  #   self.phones.each do |aPhone|
  #     hh =
  #     {
  #       lable: aPhone.label,
  #       phone_number: aPhone.number
  #     }
  #     phonesJSON << hh
  #   end
  #
  #   emailsJSON = Array.new
  #
  #   self.emails.each do |anEmail|
  #     hh = {
  #       label: anEmail.label,
  #       email: anEmail.email
  #     }
  #     emailsJSON << hh
  #   end
  #
  #   profilesJSON = Array.new
  #   self.social_profiles.each do |aProfile|
  #     hh = {
  #       label: aProfile.label,
  #       username: aProfile.username
  #     }
  #     profilesJSON << hh
  #   end
  #
  #   messengersJSON = Array.new
  #   self.instant_messengers.each do |aMessenger|
  #     hh = {
  #       label: aMessenger.label,
  #       username: aMessenger.username
  #     }
  #     messengersJSON << hh
  #   end
  #
  #   contact = {
  #     first_name: first_name,
  #     middle_name: middle_name,
  #     last_name: last_name,
  #     composite_name: composite_name,
  #     prefix: prefix,
  #     suffix: suffix,
  #     nickname: nickname,
  #     job_title: job_title,
  #     department: department,
  #     birthdate: birthdate,
  #     note: note,
  #     creation_date: creation_date,
  #     modification_date: modification_date,
  #     phones: phonesJSON,
  #     emails: emailsJSON,
  #     social_profiles: profilesJSON,
  #     instant_messengers: messengersJSON
  #   }
  #   return contact
  # end
end
