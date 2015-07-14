require 'active_support/concern'

module ContactSync
  module StringPhone
    # extend ActiveSupport::Concern
    def extract_encrypted_string_from_phone
      return self.extract_country_code.last.encrypt(:symmetric)
    end

    def extract_country_code
      string = self
      if string[0..1] == "00"
        string[0..1] = "+"
      end
      if string[0] == "+"
        breakdown = GlobalPhone.parse(string)
        if breakdown.nil?
          return ["", string]
        end
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
    alias_method :format_phone_number, :extract_country_code
  end
end

String.send(:include, ContactSync::StringPhone)
