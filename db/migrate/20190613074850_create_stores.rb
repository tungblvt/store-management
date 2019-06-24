class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :short_description
      t.text :description
      t.string :address
      t.integer :status, :default => 1
      t.boolean :is_lock, :default => false
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
