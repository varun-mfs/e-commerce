class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :invoice_number
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
