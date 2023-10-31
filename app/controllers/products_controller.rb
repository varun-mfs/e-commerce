class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :add_to_cart]
  # before_action :authenticate_admin!, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /products
  def index
    @products = Product.all
    # authorize @products
  end
  
  # GET /products/1
  def show
  end
  
  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end
  
  # GET /products/1/edit
  def edit
    authorize @product
  end
  
  # POST /products
  def create
    @product = Product.new(product_params)
    authorize @product
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    authorize @product
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    authorize @product
    if @product.destroy
      redirect_to products_url, notice: 'Product was successfully deleted.'
    else
      redirect_to products_url, notice: 'Something went wrong!'
    end
  end

  # Add product to cart
  def add_to_cart
    quantity = params[:quantity].to_i
    if current_user.cart.add_item(@product, quantity)
      redirect_to @product, notice: 'Product added to cart successfully.'
    else
      redirect_to @product, notice: 'Something went wrong!'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :in_stock, :image)
  end

  # Check if the user is an admin
  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to products_url
    end
  end
end
