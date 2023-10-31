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
end
