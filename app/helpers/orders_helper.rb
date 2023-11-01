module OrdersHelper
  def generate_invoice_number
    # Logic to generate a unique invoice number, e.g., using timestamp
    Time.now.strftime('%Y%m%d%H%M%S')
  end

  def move_cart_items_to_order(order)
    @cart.cart_items.each do |cart_item|
      # OrderItem.create(
      #   order: @order,
      #   product: cart_item.product,
      #   product_name: cart_item.product.name,
      #   product_description: cart_item.product.description,
      #   price_per_unit: cart_item.product.price,
      #   quantity: cart_item.quantity
      # )
      order.order_items.build(product: cart_item.product, quantity: cart_item.quantity)
    end
    puts "******************** moved cart_items to order_items and now DESTROYING the cart_items"
    @cart.cart_items.destroy_all
  end
  
  # get total price of cart
  def get_cart_total_price
    @cart.cart_items.sum {|item| item.quantity * item.product.price}
  end
end
