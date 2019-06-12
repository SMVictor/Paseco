module Admin
class EmployeesController < ApplicationController

  layout 'admin'
  load_and_authorize_resource
  before_action :set_employee, only: [:show, :show_inactive, :edit, :edit_inactive, :update, :update_inactive, :destroy]

  def index
    if params[:ids]
      @employees = Employee.where(id: params[:ids], active: true).all.order(name: :asc)
      respond_to do |format|
        format.js
      end
    else
      @employees = Employee.where(active: true).order(name: :asc)
    end
  end

  def inactives
    if params[:ids]
      @employees = Employee.where(id: params[:ids], active: false).order(name: :asc)
      respond_to do |format|
        format.js
      end
    else
      @employees = Employee.where(active: false).order(name: :asc)
    end
  end

  def show
  end

  def show_inactive
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def edit_inactive
  end

  def create
    params[:employee][:position] = params[:employee][:position].to_i
    @employee = Employee.create(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to admin_employees_url, notice: 'El empleado se creó correctamente.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    params[:employee][:position] = params[:employee][:position].to_i
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to admin_employees_url, notice: 'El empleado se actualizó correctamente.' }
        format.json { render json: @employee, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_inactive
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to admin_inactive_employees_url, notice: 'El empleado se actualizó correctamente.' }
        format.json { render json: @employee, status: :ok, location: @employee }
      else
        format.html { render :edit_inactive }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to admin_employees_url, notice: 'El empleado se eliminó correctamente.' }
    end
  end

  def destroy_inactive
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to admin_inactive_employees_url, notice: 'El empleado se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :identification, :account_owner, :account_identification, :id_type, :birthday, :gender, :ccss_number, :province, :canton, :district, :other, :phone, :phone_1, :emergency_contact, :emergency_number, :position_id, :payment_method, :bank, :account, :social_security, :daily_viatical, :ccss_type, :special, :active, stall_ids: [], position_ids: [], entries_attributes: [:id, :start_date, :end_date, :document, :reason_departure, :_destroy])
    end
end
end
