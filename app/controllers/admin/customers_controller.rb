module Admin
class CustomersController < ApplicationController

  layout 'admin'
  load_and_authorize_resource
  before_action :set_customer, only: [:show, :show_inactive, :edit, :edit_inactive, :update, :update_inactive, :destroy]

  def index
    if params[:ids]
      @customers = Customer.where(id: params[:ids], active: true).order(tradename: :asc)
      respond_to do |format|
        format.js
      end
    else
      @customers = Customer.where(active: true).order(tradename: :asc)
    end
  end

  def inactives
    if params[:ids]
      @customers = Customer.where(id: params[:ids], active: false).order(tradename: :asc)
      respond_to do |format|
        format.js
      end
    else
      @customers = Customer.where(active: false).order(tradename: :asc)
    end
  end

  def show
  end

  def show_inactive
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def edit_inactive
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
    if params[:customer][:active] != nil && params[:customer][:active] == "0"
      @customer.stalls.each do |stall|
        stall.active = false
        stall.save
      end
    end
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

  def update_inactive
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to admin_inactive_customers_url, notice: 'El cliente se actualizó correctamente.' }
        format.json { render json: @customer, status: :ok, location: @customer }
      else
        format.html { render :edit_inactive }
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

  def destroy_inactive
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to admin_inactive_customers_url, notice: 'El cliente se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:business_name, :tradename, :representative_id, :representative_name, :legal_document, :active, :email_1, :email_2, :phone_number_1, :phone_number, :email, :contact, :payment_method, :payment_conditions, :sector_id, entries_attributes: [:id, :start_date, :end_date, :document, :reason_departure, :_destroy])
    end
end
end
