class User < ActiveRecord::Base
  has_secure_password

  attr_accessor :email, :password, :password_confirmation
  validates_presence_of :email
  validates_presence_of :password
  validates_uniqueness_of :email



end
