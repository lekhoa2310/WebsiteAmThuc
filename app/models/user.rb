class User < ApplicationRecord
  ROLE_ADMIN = 5
  ROLE_MANAGER = 1
  ROLE_USER = 0

  before_save :hash_password
  validates :email, presence:true, uniqueness:true
  validates :password, presence:true, length: {minimum: 6, maximum: 20}, confirmation: true

  validates :name, presence:true
  validates :address, presence:true
  validates :phone, presence:true
  validates :birthday, presence:true

  def hash_password
    self.password = Digest::MD5::hexdigest(self.password)
  end

  def authenticate(password)
    password_hash = Digest::MD5::hexdigest(password)
    return true if password_hash == self.password
    return false
  end
end
