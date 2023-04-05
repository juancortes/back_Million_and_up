class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.integer :total_amount

      t.timestamps
    end
  end
end
