class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.belongs_to :district
      t.string :email
      t.string :password
      t.string :name
      t.string :address
      t.string :phone
      t.date :birthday
      t.boolean :gender
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
