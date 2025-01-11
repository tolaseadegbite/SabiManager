class ProductsController < ApplicationController
  before_action :authenticate!
  before_action :find_product, only: %w[show edit update destroy]
  before_action :find_business
  before_action :find_sidebar_businesses

  def index
    @products = @business.products.ordered
    @total_products = @business.products_count
    @pagy, @products = pagy(@products, limit: 30)
  end

  def show
    
  end

  def new
    @product = Product.new
  end

  def create
    @product = @business.products.build(product_params)
    @product.account = current_account

    if @product.save
      respond_to do |format|
        format.html { redirect_to business_products_path(@business), notice: "Product created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'product created successfully' }
      end
    else
      flash.now[:alert] = "Failed to create product. Please check the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      respond_to do |format|
        format.html { redirect_to business_product_path(@business, @product), notice: "Product updated successfully" }
        # format.turbo_stream { flash.now[:notice] = 'product updated successfully' }
      end
    else
      flash.now[:alert] = "Failed to update product. Please check the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to business_products_path(@business), notice: "Product deleted successfully" }
    end
  end

  private

  def product_params
    params.expect(product: [
      :name, 
      :description, 
      :negotiable, 
      :stock_quantity, 
      :fixed_price, 
      :min_price, 
      :max_price,  
      :product_category_id
    ])
  end

  def find_business
    @business = Business.find(params[:business_id])
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def find_sidebar_businesses
    @accordion_businesses = current_account.businesses.ordered - [@business]
  end
end
