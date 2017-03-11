class District < ApplicationRecord
  belongs_to :city
  has_many :users
  has_many :restaurants
end
