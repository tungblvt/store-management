class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :short_description
      t.text :description
      t.string :address
      t.boolean :status
      t.boolean :is_lock
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
