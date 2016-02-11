require 'rails_helper'

describe ContactSync::StringPhone do
  phone_number = '+923219428808'
  e_number = phone_number.extract_encrypted_string_from_phone
  it 'splits a valid phone number' do
    expect(phone_number.extract_country_code).to eql(["92","3219428808"])
  end
  it 'splits a valid phone number by alias method' do
    expect("+923219428808".format_phone_number).to eql(["92","3219428808"])
  end
  it 'outputs an encrypted_number from a complete_phone_number' do
    expect(e_number).to eql("hFkuSUoedTG9SuJmGG6EIw==\n")
  end
end
