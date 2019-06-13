class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :price
      t.string :image
      t.string :status
      t.boolean :is_deleted
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
