class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.belongs_to :city, index: true
      t.string :name
      t.timestamps
    end
  end
end
