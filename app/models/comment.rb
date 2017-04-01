class Comment < ApplicationRecord

  validates :content , presence: true
  validates :user_id, presence: true


  belongs_to :user
  has_many :comments, dependent: :delete_all


end
