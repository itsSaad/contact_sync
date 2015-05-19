class Email < ActiveRecord::Base

  belongs_to :contact

  def email
    return self.encrypted_email.decrypt(:symmetric)
  end

  def email=(string)
    self.encrypted_email = string.encrypt(:symmetric)
    self.encrypted_email
  end

end
