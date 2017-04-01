class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.integer :comment_id
      t.string :content
      t.timestamps
    end
  end
end
