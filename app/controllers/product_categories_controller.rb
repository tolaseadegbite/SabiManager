class ProductCategoriesController < ApplicationController
  before_action :authenticate!
  before_action :find_product_category, only: %w[show edit update destroy]
  before_action :find_business
  before_action :find_sidebar_businesses

  def index
    @product_categories = @business.product_categories.ordered
    @total_product_categories = @product_categories.size
    @pagy, @product_categories = pagy(@product_categories, limit: 30)
  end

  def show
    
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = @business.product_categories.build(product_category_params)
    @product_category.account = current_account

    if @product_category.save
      respond_to do |format|
        format.html { redirect_to business_product_categories_path(@business), notice: "Product category created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'product_category created successfully' }
      end
    else
      flash.now[:alert] = "Failed to create product category. Please check the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product_category.update(product_category_params)
      respond_to do |format|
        format.html { redirect_to business_product_category_path(@business, @product_category), notice: "Product category updated successfully" }
        # format.turbo_stream { flash.now[:notice] = 'product_category updated successfully' }
      end
    else
      flash.now[:alert] = "Failed to update product category. Please check the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product_category.destroy
    respond_to do |format|
      format.html { redirect_to business_product_categories_path(@business), notice: "Product category deleted successfully" }
    end
  end

  private

  def product_category_params
    params.require(:product_category).permit(:name, :description)
  end

  def find_business
    @business = Business.find(params[:business_id])
  end

  def find_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def find_sidebar_businesses
    @accordion_businesses = current_account.businesses.ordered - [@business]
  end
end
