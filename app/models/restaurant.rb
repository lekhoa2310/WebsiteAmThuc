class Restaurant < ApplicationRecord
  belongs_to :user
  belongs_to :district

  validates :name, presence: true
  validates :address, presence: true
  validates :district_id, presence:true
  validates :user_id, presence: true

end
