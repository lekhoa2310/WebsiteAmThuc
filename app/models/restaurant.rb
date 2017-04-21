class Restaurant < ApplicationRecord

  validates :name, presence: true
  validates :address, presence: true
  validates :district_id, presence:true
  validates :user_id, presence: true


  has_attached_file :image, styles: { small: "64x64", med: "100x100", medium: "320x480",big:"640x800" , large: "1024x1900" },
    :default_url => "/images/restaurants/default_restaurant.jpg"
validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  belongs_to :user
  belongs_to :district
  has_many :foods, dependent: :delete_all
  has_many :staffs
  has_many :orders
  has_many :reviews

end
