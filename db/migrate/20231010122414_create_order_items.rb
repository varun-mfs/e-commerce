class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :product_name
      t.string :product_description
      t.decimal :price_per_unit, precision: 8, scale: 2
      t.integer :quantity

      t.timestamps
    end
  end
end
