class City < ApplicationRecord
  has_many :districts, dependent: :destroy
  has_many :restaurants, through: :districts
end
