class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :address
      t.integer :status, :default => 0
      t.datetime :shipped_date
      t.string :subtotal
      t.references :user, :store, foreign_key: true

      t.timestamps
    end
  end
end
