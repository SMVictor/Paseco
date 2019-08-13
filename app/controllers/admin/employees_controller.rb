module Admin
class EmployeesController < ApplicationController

  layout 'admin', except: [:vacations_file]
  load_and_authorize_resource
  before_action :set_employee, only: [:show, :show_inactive, :edit, :edit_inactive, :update, :update_inactive, :destroy, :edit_vacations, :update_vacations, :edit_vacations_inactive, :update_vacations_inactive]

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
    @employee.calculate_vacations
  end

  def show_inactive
    @employee.calculate_vacations
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee.calculate_vacations
  end

  def edit_inactive
    @employee.calculate_vacations
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

    if params[:employee][:account] != @employee.account
      params[:employee][:registered_account] = false
    end
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

  def vacations_file

    @date = params[:date]
    @employee_name = params[:employee_name]
    @employee_identification = params[:employee_identification]
    @area = params[:area]
    @position = params[:position]
    @entry_date = params[:entry_date]
    @avalaible_days = params[:avalaible_days]
    @used_days = params[:used_days]
    @requested_days = params[:requested_days]
    @total_days = params[:total_days]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @period = Date.parse(@entry_date).year.to_s + "-" + Date.parse(@date).year.to_s

    respond_to do |format|
      format.html
    end
  end

  def edit_vacations
    @employee.calculate_vacations
  end

  def update_vacations
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to admin_employee_path(@employee), notice: 'El empleado se actualizó correctamente.' }
        format.json { render json: @employee, status: :ok, location: @employee }
      else
        format.html { render :show }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_vacations_inactive
    @employee.calculate_vacations
  end

  def update_vacations_inactive
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to admin_show_inactive_employee_path(@employee), notice: 'El empleado se actualizó correctamente.' }
        format.json { render json: @employee, status: :ok, location: @employee }
      else
        format.html { render :show }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :identification, :account_owner, :account_identification, :id_type, :birthday, :gender, :ccss_number, :province, :canton, :district, :other, :phone, :phone_1, :emergency_contact, :emergency_number, :position_id, :payment_method, :bank, :account, :social_security, :daily_viatical, :ccss_type, :special, :active, :registered_account, stall_ids: [], position_ids: [], entries_attributes: [:id, :start_date, :end_date, :document, :reason_departure, :_destroy], vacations_attributes: [:id, :start_date, :end_date, :included_freedays, :requested_days, :_destroy])
    end
end
end
