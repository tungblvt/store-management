class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :address
      t.integer :status
      t.datetime :shipped_date
      t.references :user, :store, foreign_key: true

      t.timestamps
    end
  end
end
