module Admin
class CustomersController < ApplicationController

  layout 'admin'
  
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  def create
    @customer = Customer.create(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to admin_customers_url, notice: 'El cliente se creó correctamente.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to admin_customers_url, notice: 'El cliente se actualizó correctamente.' }
        format.json { render json: @customer, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to admin_customers_url, notice: 'El cliente se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :business_name, :tradename, :representativr_id, :representative_name, :legal_document, :legal_document, :phone_number, :email, :contact, :payment_method, :payment_conditions)
    end
end
end
