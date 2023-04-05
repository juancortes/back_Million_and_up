class CreateDetailSales < ActiveRecord::Migration[7.0]
  def change
    create_table :detail_sales do |t|
      t.references :products, null: false, foreign_key: true
      t.integer :count
      t.float :price
      t.references :sales, null: false, foreign_key: true

      t.timestamps
    end
  end
end
