class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.belongs_to :restaurant
      t.string :kind
      t.string :name
      t.integer :price
      t.timestamps
    end
  end
end
