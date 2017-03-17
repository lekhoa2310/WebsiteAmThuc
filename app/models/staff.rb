class Staff < ApplicationRecord
  belongs_to :restaurant

  validates :restaurant_id, presence:true
  validates :kind, presence: true
  validates :name, presence: true
  validates :salary, presence: true
  validates :phone, presence:true
  validates :birthday, presence:true

end
