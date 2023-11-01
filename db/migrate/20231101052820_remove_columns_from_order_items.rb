class RemoveColumnsFromOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :product_name, :string
    remove_column :order_items, :product_description, :string
    remove_column :order_items, :price_per_unit, :decimal
  end
end
