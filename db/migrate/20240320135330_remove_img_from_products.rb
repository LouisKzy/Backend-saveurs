class RemoveImgFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :img, :string
  end
end
