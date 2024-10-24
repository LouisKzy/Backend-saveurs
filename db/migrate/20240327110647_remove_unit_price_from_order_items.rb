class RemoveUnitPriceFromOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :unit_price
  end
end
