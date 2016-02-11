class Phone < ActiveRecord::Base
  attr_accessor :number
  belongs_to :contact
  validate :check_validity

  def number
    return self.encrypted_number.try(:decrypt,:symmetric) || ""
  end

  def number=(string)
    puts "Phone Number Received: #{string}"
    self.cc_prefix, num = string.extract_country_code
    if num.blank? or num.length < 4
      self.errors[:phone_number] << "Phone number is not valid"
      return
    end
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

  def save_with_format!
    save_with_format
    save
  end
  private
  def check_validity
    if encrypted_number.blank? or number.size < 5
      errors[:number] << "Phone number is invalid"
    end
  end
end
