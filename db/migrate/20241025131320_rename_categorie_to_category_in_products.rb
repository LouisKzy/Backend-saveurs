class RenameCategorieToCategoryInProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :categorie, :category
  end
end
