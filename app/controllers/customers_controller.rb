class CustomersController < ApplicationController
  before_action :authenticate!
  before_action :find_customer, only: %w[show edit update destroy]
  before_action :find_business

  def index
    @customers = @business.customers.ordered
    @accordion_businesses = current_account.businesses.ordered - [@business]
  end

  def show
    
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = @business.customers.build(customer_params)
    @customer.account = current_account

    if @customer.save
      respond_to do |format|
        format.html { redirect_to business_customers_path(@business), notice: "Customer created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Customer created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @customer.update
      respond_to do |format|
        format.html { redirect_to business_customer_path(@business, @customer), notice: "Customer created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Podcast created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to business_customer_path(@business), notice: "Customer deleted successfully" }
    end
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :phone_number, :email, :address, :country)
    end

    def find_business
      @business = Business.find(params[:business_id])
    end

    def find_customer
      @customer = Customer.find(params[:id])
    end
end
