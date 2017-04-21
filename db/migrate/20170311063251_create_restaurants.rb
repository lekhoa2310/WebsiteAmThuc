class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.belongs_to :user
      t.belongs_to :district
      t.string  :name
      t.string :address
      t.string :phone
      t.boolean :actived, default: false
      t.float :rating, default: 0
      t.timestamps
    end
  end
end
