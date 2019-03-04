module Admin
class EmployeesController < ApplicationController

  layout 'admin'
  load_and_authorize_resource
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all.order(name: :asc)
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def edit
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

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to admin_employees_url, notice: 'El empleado se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :identification, :id_type, :document, :birthday, :gender, :ccss_number, :province, :canton, :district, :other, :phone, :phone_1, :emergency_contact, :emergency_number, :position_id, :start_date, :end_date, :payment_method, :bank, :account, :social_security, :daily_viatical, :ccss_type, :special, stall_ids: [])
    end
end
end
