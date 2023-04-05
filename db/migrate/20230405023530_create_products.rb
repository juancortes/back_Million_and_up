class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, limit: 100
      t.string :price, limit: 100
      t.text :description
      t.string :category, limit: 50
      t.string :image, limit: 150
      t.float :rate
      t.integer :count
      t.integer :count_buyed

      t.timestamps
    end
  end
end
