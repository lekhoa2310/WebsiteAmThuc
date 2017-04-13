class FoodsOfOrder < ApplicationRecord

  validates :order_id, presence: true
  validates :food_id, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  belongs_to :food
end
