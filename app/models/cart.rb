class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_item(product, quantity)
    current_item = cart_items.find_by(product: product)

    if current_item
      current_item.quantity += quantity
    else
      current_item = cart_items.build(product: product, quantity: quantity)
    end

    current_item.save
  end
end
