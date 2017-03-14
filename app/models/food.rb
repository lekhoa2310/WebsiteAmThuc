class Food < ApplicationRecord
  belongs_to :restaurant

  validates :name, presence: true
  validates :price, presence: true
  validates :restaurant_id, presence:true

end
