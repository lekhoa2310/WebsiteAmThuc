class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|
      t.belongs_to :restaurant
      t.string :kind
      t.string :name
      t.string :phone
      t.string :salary
      t.date :birthday
      t.boolean :gender
      t.timestamps
    end
  end
end
