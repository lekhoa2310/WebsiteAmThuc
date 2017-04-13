class CreateFoodsOfOrders < ActiveRecord::Migration[5.0]
  def change

    create_table :foods_of_orders do |t|
      t.belongs_to :order, index: true
      t.belongs_to :food, index: true
      t.integer :quantity
      t.integer :price
      t.timestamps
    end
  end
end
