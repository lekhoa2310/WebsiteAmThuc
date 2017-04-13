class Order < ApplicationRecord
  ORDER_PENDING = 0
  ORDER_SHIPPING = 1
  ORDER_COMPLETE = 2
  ORDER_CANCEL = 3

  validates :user_id, presence: true
  validates :restaurant_id, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  belongs_to :user
  belongs_to :restaurant
  has_many :foods_of_orders
end
