class User < ActiveRecord::Base
  before_save :generate_token
  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email

private
  def generate_token
   self.token = SecureRandom.urlsafe_base64
  end
end
