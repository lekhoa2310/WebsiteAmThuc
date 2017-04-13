class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :restaurant
      t.string :address
      t.string :phone
      t.integer :total
      t.integer :actived, default: 0
      t.timestamps
    end
  end
end
