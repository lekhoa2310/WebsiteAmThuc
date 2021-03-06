class User < ApplicationRecord
  ROLE_ADMIN = 5
  ROLE_MANAGER = 1
  ROLE_USER = 0
  before_create :hash_password

  validates :email, presence:true, uniqueness:true
  validates :password, presence:true, length: {minimum: 6}, confirmation: true
  validates :name, presence:true
  validates :address, presence:true
  validates :phone, presence:true
  validates :birthday, presence:true
  validates :district_id, presence:true

    has_attached_file :avatar, :content_type => %w(image/jpeg image/jpg image/png ), styles: { avatar: "40x40", med: "100x100", medium: "320x480",big:"640x800" , large: "1024x1900" },
   :default_url => "/images/users/person-icon.png"
   validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


  belongs_to :district
  has_many :restaurants
  has_many :posts
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :orders
  has_many :reviews, dependent: :destroy

  def hash_password
    self.password = Digest::MD5::hexdigest(self.password)
  end

  def authenticate(password)
    password_hash = Digest::MD5::hexdigest(password)
    return true if password_hash == self.password
    return false
  end

  def is_admin?
    return true if self.role == ROLE_ADMIN
    return false
  end

  def is_manager?
    return true if self.role == ROLE_MANAGER
  end
end
