class User < ActiveRecord::Base
  has_secure_password
  
  validates_presence_of :email
  validates :password, length: {minimum: 8}, allow_blank: true
  
  before_create {generate_token(:auth_token) }
  before_create { generate_token(:confirm_token) }

  #send token for password reset
  #add migration password_reset to users and reset_sent_at
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  #railscast
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
