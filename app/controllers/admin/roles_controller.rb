module Admin
class RolesController < ApplicationController

  layout 'admin'
  load_and_authorize_resource
  before_action :set_role, only: [:show, :edit, :update, :destroy, :add_role_lines, :update_role_lines, :approvals, :check_changes]
  before_action :set_stall, only: [:update_role_lines, :add_role_lines, :check_changes]
  before_action :set_payrole, only: [:show_payroles, :bncr_file, :bac_file]

  def index
    @roles = Role.all.order(start_date: :desc)
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
    @role.update(stall_ids: Stall.all.ids)
  end

  def create
    @role = Role.create(role_params)
    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_roles_url, notice: 'El role se creó correctamente.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to admin_roles_url, notice: 'El role se actualizó correctamente.' }
        format.json { render json: @role, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_role_lines
    if current_user.admin? || current_user.manager?
      respond_to do |format|
        if @role.update(role_params)
          format.html { redirect_to admin_role_lines_url, notice: 'El role se actualizó correctamente.' }
          format.json { render json: @role, status: :ok, location: @role }
        else
          format.html { render :edit }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    else
      params[:role][:role_lines_attributes].each do |key, value|

        begin
          @role_line = RoleLine.find(value[:id].to_i)
        rescue => ex
          @role_line = nil
        end

        if value[:_destroy] == "1"

          @role_line.role_lines_copy = RoleLinesCopy.new if @role_line.role_lines_copy == nil

          @role_line.role_lines_copy.date        = @role_line.date
          @role_line.role_lines_copy.substall    = @role_line.substall
          @role_line.role_lines_copy.employee_id = @role_line.employee_id
          @role_line.role_lines_copy.shift_id    = @role_line.shift_id
          @role_line.role_lines_copy.stall_id    = @role_line.stall.id
          @role_line.role_lines_copy.stall_id    = @role_line.stall.id
          @role_line.role_lines_copy.role_id     = @role_line.role.id
          @role_line.role_lines_copy.comment     = @role_line.comment
          @role_line.role_lines_copy.action      = "delete"
          @role_line.role_lines_copy.save

        elsif @role_line == nil

          @role_lines_copy = RoleLinesCopy.create(date: value[:date], substall: value[:substall], employee_id: value[:employee_id],
            shift_id: value[:shift_id], stall_id: @stall.id, role_id: @role.id, comment: value[:comment], action: "create")

        else
          @role_line.date        = value[:date]
          @role_line.substall    = value[:substall]
          @role_line.employee_id = value[:employee_id]
          @role_line.shift_id    = value[:shift_id]
          @role_line.comment     = value[:comment]
          if @role_line.changed?

            @role_line.role_lines_copy = RoleLinesCopy.new if @role_line.role_lines_copy == nil
            
            @role_line.role_lines_copy.date        = value[:date]
            @role_line.role_lines_copy.substall    = value[:substall]
            @role_line.role_lines_copy.employee_id = value[:employee_id]
            @role_line.role_lines_copy.shift_id    = value[:shift_id]
            @role_line.role_lines_copy.comment     = value[:comment]
            @role_line.role_lines_copy.stall_id    = @stall.id
            @role_line.role_lines_copy.role_id     = @role.id
            @role_line.role_lines_copy.action      = "update"
            @role_line.role_lines_copy.save
          end
        end
      end
      respond_to do |format|
        format.html { redirect_to admin_role_lines_url, notice: 'Su solicitud ha sido enviada para revisión.' }
        format.json { render json: @role, status: :ok, location: @role }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_url, notice: 'El role se eliminó correctamente.' }
    end
  end

  def add_role_lines
    @substalls = []
    @count = 1
    while @count <= @stall.substalls.to_i
      @substalls[@count-1] = "Puesto " + @count.to_s
      @count = @count+1
    end
  end

  def approvals 
  end

  def check_changes
    @changes = RoleLinesCopy.where(role_line_id: RoleLine.where("stall_id = ?", @stall.id).ids).or(RoleLinesCopy.where(stall_id: @stall.id))
  end

  def approve_create
    @change    = RoleLinesCopy.find(params[:change_id])
    @role_line = RoleLine.create(date: @change.date, substall: @change.substall, hours: @change.hours, role_id: @change.role_id, employee_id: @change.employee_id, stall_id: @change.stall_id, shift_id: @change.shift_id, comment: @change.comment)
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Los datos fueron registrados correctamente.' }
    end
  end

  def approve_update
    @change    = RoleLinesCopy.find(params[:change_id])
    @role_line = @change.role_line.update(date: @change.date, substall: @change.substall, hours: @change.hours, role_id: @change.role_id, employee_id: @change.employee_id, stall_id: @change.stall_id, shift_id: @change.shift_id, comment: @change.comment)
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Modificación exitosa.' }
    end
  end

  def approve_destroy
    @change    = RoleLinesCopy.find(params[:change_id])
    @role_line = @change.role_line.destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Los datos fueron eliminados correctamente.' }
    end
  end

  def deny_change
    @change    = RoleLinesCopy.find(params[:change_id])
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Cambio denegado' }
    end
  end

  def index_payroles
    @payroles = Role.all.order(start_date: :desc)
  end

  def show_payroles

    @ccss_percent = 0.1035
    @ccss_amount = 12500

    @employees = Employee.all
    @employees.each do |employee|
      if !employee.special
        regular_employess_payrole(employee)
      else
        iregular_employess_payrole(employee)
      end
    end
  end

  def bncr_file
   @bn_info = BncrInfo.first
   @total = 0
   @sumAccounts = @bn_info.account[8,6].to_i

   @payrole.payrole_lines.each do |payrole|
    if payrole.employee.bank == "BNCR"
      @total += payrole.net_salary.to_i
      @sumAccounts += @bn_info.account[8,6].to_i
    end
   end
   @total = @total*100
   respond_to do |format|
      format.xls
    end
  end

  def bac_file
   @bac_info = BacInfo.first
   @total = 0
   @count = 1

   @payrole.payrole_lines.each do |payrole|
    if payrole.employee.bank == "BAC"
      @total += payrole.net_salary.to_i
      @count += 1
    end
   end
   @total = @total*100
   respond_to do |format|
      format.xls
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    def set_stall
      @stall = Stall.find(params[:stall_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payrole
      @payrole = Role.find(params[:id])
    end

    def regular_employess_payrole(employee)

      @role_lines = @payrole.role_lines.where(employee: employee)

      @min_salary        = 0
      @extra_salary      = 0
      @total_extra_hours = 0
      @viatical          = 0
      @extra_payments    = 0
      @deductions        = 0

      @role_lines.each do |role_line|
        @stall = role_line.stall
        @shift = role_line.shift

        if @shift.name != "Libre"
          @hour_cost = @stall.min_salary.to_f/@shift.time.to_f/30
        else
           @min_salary += @stall.min_salary.to_f/30
        end

        @normal_hours = 0
        @extra_hours  = 0

        @extra_hours = role_line.hours.to_f - @shift.time.to_f if role_line.hours.to_f > @shift.time.to_f
        @total_extra_hours += @extra_hours
        @normal_hours = role_line.hours.to_f - @extra_hours
        @min_salary += @normal_hours * @hour_cost
        @extra_salary += ((@stall.min_salary.to_f/30)/8) * @shift.extra_time_cost.to_f * @extra_hours
        @extra_payments += role_line.extra_payments.to_f
        @deductions += role_line.deductions.to_f

        if employee.daily_viatical == 'yes'
          @viatical += @stall.daily_viatical.to_f
        end

      end
      @payrole_line = @payrole.payrole_lines.where(employee_id: employee.id)[0]
      if @payrole_line == nil
        @payrole_line = @payrole.payrole_lines.create([{ min_salary: '0', extra_hours: '0', daily_viatical: '0', ccss_deduction: '0', extra_payments: '0', deductions: '0', net_salary: '0', employee_id: employee.id }])[0]
      end
      @payrole_line.num_worked_days = @role_lines.length
      @payrole_line.min_salary      = @min_salary.round(0)
      @payrole_line.num_extra_hours = @total_extra_hours
      @payrole_line.extra_hours     = @extra_salary.round(0)
      @payrole_line.daily_viatical  = @viatical.round(0)
      @gross_salary  = (@min_salary + @extra_salary).round(0)

      if employee.social_security == "Porcentaje"
        if employee.ccss_type == "yes"
          @payrole_line.ccss_deduction = (@gross_salary * @ccss_percent).round(0)
          @payrole_line.net_salary = (@gross_salary - (@gross_salary * @ccss_percent) + @viatical + @extra_payments - @deductions).round(0)
        else
          @payrole_line.ccss_deduction = (@payrole_line.min_salary.to_f * @ccss_percent).round(0)
          @payrole_line.net_salary = (@gross_salary - (@payrole_line.min_salary.to_f * @ccss_percent) + @viatical + @extra_payments - @deductions).round(0)
        end
      else
        @payrole_line.ccss_deduction = @ccss_amount.round(0)
        @payrole_line.net_salary = (@gross_salary - @ccss_amount + @viatical + @extra_payments - @deductions).round(0)
      end
      @payrole_line.extra_payments = @extra_payments.round(0)
      @payrole_line.deductions = @deductions.round(0)
      @payrole_line.save
    end

    def iregular_employess_payrole(employee)

      @role_lines = @payrole.role_lines.where(employee: employee)
      @payrole_line = @payrole.payrole_lines.where(employee_id: employee.id)[0]
      if @payrole_line == nil
        @payrole_line = @payrole.payrole_lines.create([{ min_salary: '0', extra_hours: '0', daily_viatical: '0', ccss_deduction: '0', extra_payments: '0', deductions: '0', net_salary: '0', employee_id: employee.id }])[0]
      end
      @day_cost = employee.position.salary.to_f/30

      @min_salary     = 0
      @extra_salary   = 0
      @viatical       = 0
      @ccss_deduction = 0
      @net_salary     = 0
      @extra_payments    = 0
      @deductions        = 0

      @role_lines.each do |role_line|

        @stall = role_line.stall
        @min_salary += @day_cost
        @extra_payments += role_line.extra_payments.to_f
        @deductions += role_line.deductions.to_f

        if employee.daily_viatical == 'yes'
          @viatical += @stall.daily_viatical.to_f
        end
      end

      @gross_salary = (@min_salary + @extra_salary).round(2)

      if employee.social_security == "Porcentaje"
        if employee.ccss_type == "yes"
          @ccss_deduction = (@gross_salary * @ccss_percent).round(2)
          @net_salary = (@gross_salary - @gross_salary * @ccss_percent + @viatical + @extra_payments - @deductions).round(0)
        else
          @ccss_deduction = (@min_salary.to_f * @ccss_percent).round(2)
          @net_salary = (@gross_salary - @min_salary.to_f * @ccss_percent + @viatical + @extra_payments - @deductions).round(0)
        end
      else
        @ccss_deduction = @ccss_amount
        @net_salary = (@gross_salary - @ccss_amount + @viatical + @extra_payments - @deductions).round(0)
      end

      @payrole_line.num_worked_days = @role_lines.length
      @payrole_line.min_salary      = @min_salary.round(2)
      @payrole_line.num_extra_hours = 0
      @payrole_line.extra_hours     = 0
      @payrole_line.daily_viatical  = @viatical.round(2)
      @payrole_line.ccss_deduction  = @ccss_deduction
      @payrole_line.extra_payments  = @extra_payments
      @payrole_line.deductions      = @deductions
      @payrole_line.net_salary      = @net_salary
      @payrole_line.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :start_date, :end_date, stall_ids: [], role_lines_attributes: [:id, :date, :employee_id, :stall_id, :shift_id, :substall, :comment, :hours, :extra_payments, :extra_payments_description, :deductions, :deductions_description, :_destroy])
    end
end
end
