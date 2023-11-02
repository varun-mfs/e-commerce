class OrdersController < ApplicationController
  include OrdersHelper
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def create
    @cart = current_user.cart
    order_params = {
      user: current_user,
      invoice_number: generate_invoice_number,
      total_price: get_cart_total_price
    }
    @order = Order.create(order_params)
    move_cart_items_to_order(@order)
    if @order.save
      redirect_to order_path(@order), notice: 'Order placed successfully.'
    else
      redirect_to cart_path, alert: 'Error placing the order.'
    end
  end

  def show
    begin
      @order = Order.find(params[:id])
    rescue
      redirect_to orders_path
    end
  end  

  def update
    @order = Order.find(params[:id])
    new_status = params[:order][:status]&.to_sym
    if new_status && @order.update(status: new_status)
      redirect_to order_path(@order), notice: "Order status updated to #{new_status.capitalize}."
    else
      redirect_to order_path(@order), alert: 'Error updating order status.'
    end
  end

  def destroy
    authorize @order
    @order = Order.find(params[:id])
    if @order.destroy
      redirect_to orders_path, notice: 'Order deleted successfully.'
    else
      redirect_to orders_path, notice: 'Something went wrong!'
    end
  end
end
