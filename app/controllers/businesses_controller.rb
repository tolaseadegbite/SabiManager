class BusinessesController < ApplicationController
  before_action :authenticate!
  before_action :find_business, only: %w[show edit update destroy]

  def index
    @businesses = current_account.businesses
  end

  def show
    
  end

  def new
    @business = Business.new
  end

  def create
    @business = current_account.businesses.build(business_params)

    if @business.save
      respond_to do |format|
        format.html { redirect_to @business, notice: "Business created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Podcast created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @business.update(business_params)   
      respond_to do |format| 
        format.html { redirect_to @business, notice: "Business updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    
  end

  private

    def business_params
      params.require(:business).permit(:name, :description, :tax_rate, :logo, :currency)
    end

    def find_business
      @business = current_account.businesses.find(params[:id])
    end
end
