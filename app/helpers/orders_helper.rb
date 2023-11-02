module OrdersHelper
  def generate_invoice_number
    # Logic to generate a unique invoice number, e.g., using timestamp
    Time.now.strftime('%Y%m%d%H%M%S')
  end

  def move_cart_items_to_order(order)
    order_items = []
    @cart.cart_items.each do |cart_item|
      order_items << {
        order_id: @order.id,
        product_id: cart_item.product.id,
        quantity: cart_item.quantity
    }
    end
    OrderItem.create(order_items)
    @cart.cart_items.destroy_all    
  end
  
  # get total price of cart
  def get_cart_total_price
    @cart.cart_items.sum {|item| item.quantity * item.product.price}
  end

end
