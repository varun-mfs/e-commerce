class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      redirect_to cart_path, notice: 'Product removed from the cart.'
    else
      flash[:alert] = 'Product not found.'
      redirect_to cart_path
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if params[:operation] == 'increase'
      @cart_item.quantity += 1
      if @cart_item.save
        redirect_to
      end
    else
      @cart_item.quantity -= 1
      if @cart_item.quantity == 0
        @cart_item.destroy!
        redirect_to
      else
        @cart_item.save
          redirect_to
      end
    end
  end
end
