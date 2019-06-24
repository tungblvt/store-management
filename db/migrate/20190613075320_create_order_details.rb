class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.string :price
      t.string :total
      t.references :order, :product, foreign_key: true

      t.timestamps
    end
  end
end
