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

  private
  def extract_country_code(string)
    if string[0..1] == "00"
      string[0..1] = "+"
    end
    if string[0] == "+"
      breakdown = GlobalPhone.parse(string)
      prefix = breakdown.country_code
      num = breakdown.national_string
      return [prefix,num]
    elsif string[0] == "0"
      num = string[1..-1]
      prefix = "0"
      return [prefix, num]
    else
      return ["", string]
    end
  end
end
