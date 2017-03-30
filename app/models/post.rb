class Post < ApplicationRecord

  validates :user_id, presence: true
  validates :content , presence: true

  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
end
