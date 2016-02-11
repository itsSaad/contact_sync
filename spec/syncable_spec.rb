require 'rails_helper'

describe 'ContactSync::StringPhone' do
  it 'can split a valid phone number' do
    expect("00923219428808".extract_country_code).to eql(["92","3219428808"])
  end
end
