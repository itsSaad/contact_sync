module ContactSync
  module Syncable
    def phone_number
      return self.encrypted_number.try(:decrypt,:symmetric) || ""
    end

    def phone_number=(string)
      self.cc_prefix, num = string.extract_country_code
      self.encrypted_number = num.encrypt(:symmetric)
      self.encrypted_number
    end

    def complete_phone_number
      if self.cc_prefix.blank?
        "00#{self.phone_number}"
      elsif self.cc_prefix == "0"
        "#{self.cc_prefix}#{self.phone_number}"
      else
        "+#{self.cc_prefix}#{self.phone_number}"
      end
    end
    def sync_contacts(contact_hash = {})
      result = {:new => {failed:[], duplicate: []}, modified: {failed:[]}, deleted: {failed:[]}}
      raise ArgumentError, "You need to provide contacts hash." if contact_hash.blank?
      # raise ArgumentError, "You need to provide Device Identifier as deviceID" if contact_hash[:device_id].blank?
      ##########################################################################
      #########################Create new Contacts##############################
      if !contact_hash[:new].blank?
        contacts = contact_hash[:new]
        contacts.each do |aContact|
          phones = aContact[:phones]
          emails = aContact[:emails]
          aContact.delete :phones
          aContact.delete :emails
          newContact = Contact.new(contact_params(aContact))
          begin
            # newContact = Contact.new(contact_params(aContact))
            # newContact.device_id = contact_hash[:device_id]
            if phones && phones.class == Array
              phones.each do |aPhone|
                newContact.phones.build(phone_params(aPhone))
              end
            end
            if emails && emails.class == Array
              emails.each do |anEmail|
                newContact.emails.build(email_params(anEmail))
              end
            end
            self.contacts << newContact
            puts "Trying to save Contact: #{newContact}"
            if newContact.save
              # result[:new][:success] << newContact.record_id
            else
              puts "Failed Saving. Error: #{newContact.errors.full_messages}"
              result[:new][:failed] << newContact.record_id
            end
          rescue ActiveRecord::RecordNotUnique => e
            puts "Rescuing Duplicate Record"
            result[:new][:duplicate] << newContact.record_id
            newContact.destroy
          end
        end
      end
      ##########################################################################
      ########################Modify Contacts###################################
      if !contact_hash[:modified].blank?
        modified_contacts = contact_hash[:modified]
        modified_contacts.each do |con|
          theContact = self.contacts.find_by_record_id(con[:record_id])
          if ! theContact.blank?
            if !theContact.update_attributes(contact_params(con))
              result[:modified][:failed] << theContact.record_id
            else
              # result[:modified][:success] << theContact.record_id
            end
          end
        end
      end
      ##########################################################################
      ########################Delete Contacts###################################
      if !contact_hash[:deleted].blank?
        delete_contacts = contact_hash[:deleted]
        delete_contacts.each do |con|
          if self.contacts.find_by_record_id(con[:record_id].to_i).destroy
            # result[:deleted][:success] << con[:record_id]
          else
            result[:deleted][:failed] << con[:record_id]
          end
        end
      end
      after_contact_sync
      self.save
      return result
    end


    def matched_contacts
      matched_users = []
      other_contacts = []
      self.contacts.includes([:emails, :phones]).each do |aKon|
        #Check Phones to Match existing users.
        matches = false
        aKon.phones.each do |ph|
          u = User.where(encrypted_number: ph.number.encrypt(:symmetric)).limit(1).first
          if !u.blank?
            matches = true
            matched_users << {user: u.id, phone: ph.id, contact: aKon.id}
          end
        end
        #Check Emails to Match existing users.
        aKon.emails.each do |em|
          u = User.where(email: em.email).limit(1).first
          if !u.blank?
            matches = true
            matched_users << {user: u.id, email: em.id, contact: aKon.id}
          end
        end
        other_contacts << aKon if !matches
      end
      return matched_users
    end

    def remove_all_contacts
      self.contacts.destroy_all
      if self.contacts.count > 0
        return false
      end
      return true
    end

    private
    def contact_params(aContact)
      aContact.permit(:composite_name, :first_name, :middle_name, :last_name, :prefix, :suffix, :nickname, :job_title, :department, :organization, :birthdate, :note, :creation_date, :modification_date, :record_id)
    end

    def phone_params aPhone
      aPhone.permit(:label, :number, :encrypted_number, :cc_prefix)
    end

    def email_params anEmail
      anEmail.permit(:label, :email, :encrypted_email)
    end

    def after_contact_sync
      self.last_contact_sync = DateTime.now.utc
    end
  end
end
