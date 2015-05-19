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
      else
        "+#{self.cc_prefix}#{self.phone_number}"
      end
    end
    def sync_contacts(contact_hash = {})
      result = {:new => {success:[], failed:[]}, modified: {success:[], failed:[]}, deleted: {success:[], failed:[]}}
      raise ArgumentError, "You need to provide contacts hash." if contact_hash.blank?

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
          if phones
            phones.each do |aPhone|
              newContact.phones.build(phone_params(aPhone))
            end
          end
          if emails
            emails.each do |anEmail|
              newContact.emails.build(email_params(anEmail))
            end
          end
          if newContact.save
            # result[:new][:success] << newContact.record_id
            self.contacts << newContact
          else
            result[:new][:failed] << newContact.record_id
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
      matched_contacts = []
      user_phones = []
      user_emails = []
      self.contacts.each do |con|
        user_phones.concat con.phones
        user_emails.concat con.emails
      end

      user_phones.each do |phone|
        u = User.where(encrypted_number: phone.number.encrypt(:symmetric)).limit(1).first
        matched_contacts << u.id unless u.blank?
      end
      user_emails.each do |mail|
        u = User.where(encrypted_email: mail.email.encrypt(:symmetric)).limit(1).first
        matched_contacts << u.id unless u.blank?
      end
      return matched_contacts
    end

    private
    def contact_params(aContact)
      aContact.permit(:composite_name, :first_name, :middle_name, :last_name, :prefix, :suffix, :nickname, :job_title, :department, :organization, :birthdate, :note, :creation_date, :modification_date, :record_id)
    end

    def phone_params aPhone
      aPhone.permit(:label, :number)
    end

    def email_params anEmail
      anEmail.permit(:label, :email)
    end

    def after_contact_sync
      self.last_contact_sync = DateTime.now.utc
    end
  end
end
