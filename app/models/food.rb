class Food < ApplicationRecord

  belongs_to :restaurant

  validates :name, presence: true
  validates :price, presence: true
  validates :restaurant_id, presence:true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", medium: "320x480",big:"640x800" , large: "1024x1900" },
 :default_url => "/images/foods/food.png"
 validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
