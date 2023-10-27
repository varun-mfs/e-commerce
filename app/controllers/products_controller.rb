class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    begin
      @product.destroy
      redirect_to products_url, notice: 'Product was successfully deleted.'
    rescue StandardError => e
      flash[:alert] = "Error destroying the product: #{e.message}"
      redirect_to products_url
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :in_stock)
  end

  # Check if the user is an admin
  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to products_url
    end
  end
end
