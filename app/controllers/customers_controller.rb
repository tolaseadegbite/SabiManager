class CustomersController < ApplicationController
  before_action :authenticate!
  before_action :find_customer, only: %w[show edit update destroy]
  before_action :find_business
  before_action :find_sidebar_businesses

  def index
    @customers = @business.customers.ordered
    @total_customers = @business.customers_count
    @pagy, @customers = pagy(@customers, limit: 30)
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
      flash.now[:alert] = "Failed to create customer. Please check the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      respond_to do |format|
        format.html { redirect_to business_customer_path(@business, @customer), notice: "Customer updated successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Customer updated successfully' }
      end
    else
      flash.now[:alert] = "Failed to update customer. Please check the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to business_customers_path(@business), notice: "Customer deleted successfully" }
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

  def find_sidebar_businesses
    @accordion_businesses = current_account.businesses.ordered - [@business]
  end
end