module Admin
class EmployeesController < ApplicationController

  layout 'admin', except: [:vacations_file]
  load_and_authorize_resource
  before_action :set_employee, only: [:show, :show_inactive, :edit, :edit_inactive, :update, :update_inactive, :destroy, :edit_vacations, :update_vacations, :edit_vacations_inactive, :update_vacations_inactive, :edit_bonuses, :update_bonuses]

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

    from = Time.now.year
    to   = Time.now.year

    if @employee.entries
      if @employee.entries && @employee.entries.last && @employee.entries.last.start_date && @employee.entries.last.start_date != ""
        from = @employee.entries.last.start_date.to_date.year
      end
    end
    (from..to).each do |i|
      @employee.calculate_christmas_bonification(i)
    end
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
    @stall = params[:stall]
    @entry_date = params[:entry_date]
    @departure_date = params[:departure_date]
    @avalaible_days = params[:avalaible_days]
    @used_days = params[:used_days]
    @requested_days = params[:requested_days]
    @total_days = params[:total_days]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @period = params[:period]

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

  def edit_bonuses
    @bonus = @employee.christmas_bonifications.find(params[:bonus])
    @lines = []
    @bonus.christmas_bonification_lines.each do |line|
      if @lines[0] == nil
        @lines << line
      else
        flat = true
        @lines.each_with_index do |listed_line, index|
          if line.start_date.to_date > listed_line.start_date.to_date
            @lines.insert(index, line)
            flat = false
            break
          end
        end
        if flat
          @lines << line
        end
      end
    end
  end
  def update_bonuses
    @bonus = @employee.christmas_bonifications.find(params[:bonus])

    respond_to do |format|
      if @bonus.update(bonus_params)
        total = 0

        @bonus.christmas_bonification_lines.each do |line|
          line.total = line.base_salary.to_f + line.extra_payment.to_f + line.viaticals.to_f
          total += line.total.to_f
        end

        @bonus.total = total / 12
        @bonus.save

        format.html { redirect_to admin_employee_path(@employee), notice: 'La información se actualizó correctamente.' }
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
      params.require(:employee).permit(:name, :identification, :account_owner, :account_identification, :id_type, :birthday, :gender, :ccss_number, :province, :canton, :district, :other, :phone, :phone_1, :emergency_contact, :emergency_number, :payment_method, :bank, :account, :social_security, :daily_viatical, :ccss_type, :special, :active, :registered_account, :email, :sub_service_id, stall_ids: [], position_ids: [], entries_attributes: [:id, :start_date, :end_date, :document, :reason_departure, :_destroy], vacations_attributes: [:id, :start_date, :end_date, :included_freedays, :requested_days, :period, :_destroy])
    end

    def bonus_params
      params.require(:christmas_bonification).permit(christmas_bonification_lines_attributes: [:id, :start_date, :end_date, :base_salary, :extra_payment, :viaticals, :_destroy])
    end
end
end
