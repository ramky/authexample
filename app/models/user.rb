class User < ActiveRecord::Base
  include BCrypt
  before_save :generate_token
  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email
  has_secure_password validations: false
  has_many :tasks

private

  def generate_token
   self.token = SecureRandom.hex(16)
  end
end
