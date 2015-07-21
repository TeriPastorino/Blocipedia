class User < ActiveRecord::Base
  has_secure_password
  
  validates_presence_of :email, :name
  validates :password, length: {minimum: 8}, allow_blank: true
  
  has_many :wikis

  before_create {generate_token(:auth_token) }
  before_create { generate_token(:confirm_token) }

  after_initialize :set_role

  def admin?
    role == 'admin'
  end

  def premium?
    role = 'premium'
  end

  def upgrade
    self.update_attributes(:role => 'premium')
  end

  def downgrade
    self.update_attributes(:role => 'standard')
  end

  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    #protects against unwanted pw validation
    save!(validate: false)
  end

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

  #set default role to standard  
  def set_role
    self.role ||= 'standard'
  end
end
