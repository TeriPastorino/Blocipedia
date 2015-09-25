class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :title, length: {minimum: 6}, presence: true
  validates :body, length: {minimum: 30}, presence: true
  validates :user, presence: true


  
end
