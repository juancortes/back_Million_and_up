class CreateShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_carts do |t|
      t.references :products, null: false, foreign_key: true
      t.integer :count
      t.float :price

      t.timestamps
    end
  end
end
