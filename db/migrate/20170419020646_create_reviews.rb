class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :restaurant
      t.float :rating
      t.string :content
      t.timestamps
    end
  end
end
