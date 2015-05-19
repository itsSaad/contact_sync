class Phone < ActiveRecord::Base
  attr_accessor :number
  belongs_to :contact

  def number
    return self.encrypted_number.try(:decrypt,:symmetric) || ""
  end

  def number=(string)
    self.cc_prefix, num = string.extract_country_code
    self.encrypted_number = num.encrypt(:symmetric)
    self.encrypted_number
  end

  def save_with_format!
    save_with_format
    save
  end
end
