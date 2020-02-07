module Admin
class PaymentsController < ApplicationController
  
  layout 'admin'
  load_and_authorize_resource
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.all.order(name: :asc)
  end

  def show
  end

  def new
    @payment = Payment.new
    @payments =  Shift.all.order(name: :asc)
  end

  def edit
  end

  def create
    @payment = Payment.create(payment_params)

    Shift.create([
      {name: "Libre",       time: "0", extra_time_cost: "0", payment_id: @payment.id}, 
      {name: "Incapacidad", time: "0", extra_time_cost: "0", payment_id: @payment.id}, 
      {name: "Permiso",     time: "0", extra_time_cost: "0", payment_id: @payment.id}, 
      {name: "Ausente",     time: "0", extra_time_cost: "0", payment_id: @payment.id}, 
      {name: "Vacaciones",  time: "0", extra_time_cost: "0", payment_id: @payment.id}])

    respond_to do |format|
      if @payment.save
        format.html { redirect_to admin_payments_url, notice: 'El tipo de pago se creó correctamente.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to admin_payments_url, notice: 'El tipo de pago se actualizó correctamente.' }
        format.json { render json: @payment, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_payments_url, notice: 'El tipo de pago se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:name, :description, shifts_attributes: [:id, :name, :start_hour, :time, :extra_time_cost, :active, :_destroy])
    end
end
end
