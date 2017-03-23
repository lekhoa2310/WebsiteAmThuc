class Restaurant < ApplicationRecord
  belongs_to :user
  belongs_to :district
  has_many :foods, dependent: :delete_all
  has_many :staffs

  validates :name, presence: true
  validates :address, presence: true
  validates :district_id, presence:true
  validates :user_id, presence: true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", medium: "320x480",big:"640x800" , large: "1024x1900" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
