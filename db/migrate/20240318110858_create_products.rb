class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :img
      t.decimal :price
      t.text :description
      t.string :origin
      t.string :variety
      t.string :categorie
      t.integer :quantity

      t.timestamps
    end
  end
end
