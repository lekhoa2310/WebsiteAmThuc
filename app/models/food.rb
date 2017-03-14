class Food < ApplicationRecord
  belongs_to :restaurant

  validates :name, presence: true
  validates :price, presence: true
  validates :restaurant_id, presence:true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", medium: "320x480",big:"640x800" , large: "1024x1900" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
