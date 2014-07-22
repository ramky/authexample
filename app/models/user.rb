class User < ActiveRecord::Base
  before_save :generate_token
  validates_presence_of :email, :name, :password

private
  def generate_token
   self.token = SecureRandom.urlsafe_base64
  end
end
