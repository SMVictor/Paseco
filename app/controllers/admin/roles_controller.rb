module Admin
class RolesController < ApplicationController

  layout 'admin'
  load_and_authorize_resource
  before_action :set_role, only: [:show, :edit, :update, :destroy, :add_role_lines, :update_role_lines, :approvals, :check_changes, :stall_summary, :stalls_hours]
  before_action :set_stall, only: [:update_role_lines, :add_role_lines, :check_changes, :stall_summary]
  before_action :set_payrole, only: [:show_payroles, :bncr_file, :bac_file, :payrole_detail, :show_old_payrole, :budget, :old_budget, :budget_detail, :old_payrole_detail, :old_budget_detail]

  def index
    @roles = Role.all.order(id: :desc)
  end

  def show
  end

  def stall_summary
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
    if current_user.admin?
      if params[:ajax] 

        if params[:create]

          @substalls = []
          @count = 1
          while @count <= @stall.substalls.to_i
            @substalls[@count-1] = "Puesto " + @count.to_s
            @count = @count+1
          end
          @employee = Employee.find(params[:employee_id]) if params[:employee_id] != "0"

          @shift = Payment.find(2).shifts.first
          @shift = @stall.quote.payment.shifts.first if @stall.quote.payment
          @date = @role.end_date.to_date.strftime("%m/%d/%Y")
          RoleLine.create(role: @role, stall: @stall, employee: @employee, shift: @shift, position: @employee.positions.first, date: @date)

          respond_to do |format|
            begin
              @role.update(role_params)
              @role_lines = @role.role_lines.where(stall_id: @stall.id, employee: @employee).order(date: :asc)
              format.js
            rescue Exception => e
              @role_lines = @role.role_lines.where(stall_id: @stall.id, employee: @employee).order(date: :asc)
              format.js
            end
          end
        else
          @role.update(role_params)
        end
      else
        respond_to do |format|
          if @role.update(role_params)
            format.html { redirect_to admin_role_lines_url, notice: 'El role se actualizó correctamente.' }
            format.json { render json: @role, status: :ok, location: @role }
          else
            format.html { render :edit }
            format.json { render json: @role.errors, status: :unprocessable_entity }
          end
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
      @users = User.where(role: 0)
      @users.each do |user|
        UserMailer.send_notification(user, current_user).deliver_now
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

    @employee = Employee.find(params[:employee_id]) if params[:employee_id] != "0"  
    @role_lines = @role.role_lines.where(stall_id: @stall.id, employee: @employee).order(date: :asc)

    if params[:ajax]
      respond_to do |format|
        format.js
      end
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
    @payroles = Role.all.order(id: :desc)
  end

  def show_payroles

    if params[:ids]
      @payrole_lines = @payrole.payrole_lines.where(id: params[:ids]).includes(:employee).order("employees.name asc")
      respond_to do |format|
        format.js
      end
    else
      @payrole_lines = @payrole.payrole_lines.includes(:employee).order("employees.name asc")
      @payrole_lines.delete_all

      @employees = Employee.where(active: true).or(Employee.where(id: @role.role_lines.pluck("employee_id").uniq)).order(name: :asc)
      @employees.each do |employee|
        @role_lines = @payrole.role_lines.where(employee: employee)

        @total_day_salary     = 0 
        @total_extra_hours    = 0 
        @total_extra_salary   = 0 
        @total_extra_payments = 0 
        @total_deductions     = 0 
        @total_viatical       = 0
        @total_holidays       = 0

        has_night =  @role_lines.joins(:shift).where("name = 'Noche'").length

        @role_lines.each do |line|

          employee.calculate_day_salary(line, has_night)
          employee.calculate_daily_viatical(line)

          @total_day_salary     += employee.day_salary
          @total_extra_hours    += employee.extra_day_hours 
          @total_extra_salary   += employee.extra_day_salary 
          @total_extra_payments += line.extra_payments.to_f 
          @total_deductions     += line.deductions.to_f 
          @total_viatical       += employee.viatical
          @total_holidays       += employee.holiday 
        end
        employee.calculate_payment(@role_lines.length, @total_day_salary, @total_extra_hours, @total_extra_salary, @total_viatical, @total_extra_payments, @total_deductions, @total_holidays)

        @payrole_line = @payrole.payrole_lines.new([{ min_salary: '0', extra_hours: '0', daily_viatical: '0', ccss_deduction: '0', extra_payments: '0', deductions: '0', net_salary: '0', employee_id: employee.id }])[0]

        @payrole_line.num_worked_days = employee.total_days
        @payrole_line.min_salary      = employee.total_day_salary.round(2)
        @payrole_line.num_extra_hours = employee.total_extra_hours
        @payrole_line.extra_hours     = employee.total_extra_salary.round(2)
        @payrole_line.daily_viatical  = employee.total_viatical.round(2)
        @payrole_line.ccss_deduction  = employee.ccss_deduction.round(2)
        @payrole_line.net_salary      = employee.net_salary.round(2)
        @payrole_line.extra_payments  = employee.total_exta_payments.round(2)
        @payrole_line.deductions      = employee.total_deductions.round(2)
        @payrole_line.holidays        = employee.total_holidays.round(2)
        @payrole_line.bank            = employee.bank
        @payrole_line.account         = employee.account
        @payrole_line.save
      end
    end
  end

  def show_old_payrole
    if params[:ids]
      @payrole_lines = @payrole.payrole_lines.where(id: params[:ids]).includes(:employee).order("employees.name asc")
      respond_to do |format|
        format.js
      end
    else
      @payrole_lines = @payrole.payrole_lines.includes(:employee).order("employees.name asc")
    end
  end

  def bncr_file
   @bn_info = BncrInfo.first
   @total = 0
   @sumAccounts = @bn_info.account[8,6].to_i

   @payrole.payrole_lines.each do |payrole|
    if payrole.employee.bank == "BNCR" && payrole.employee.account != "" && payrole.net_salary.to_i > 0
      @total += payrole.net_salary.to_f
      @sumAccounts += payrole.employee.account[8,6].to_i
    end
   end

   @total         = @total.round(2)
   @total_amount  = @total.to_s.split(".")[0]
   @total_decimal = "00"

   if  @total.to_s.split(".")[1]
     @total_decimal = @total.to_s.split(".")[1] + ("0" * (2 - @total.to_s.split(".")[1].length))
   end

   @total_amount_2  = (@total*2).to_s.split(".")[0]
   @total_decimal_2 = "00"

   if  (@total*2).to_s.split(".")[1]
     @total_decimal_2 = (@total*2).to_s.split(".")[1] + ("0" * (2 - (@total*2).to_s.split(".")[1].length))
   end

   respond_to do |format|
      format.xls
    end
    
  end

  def bac_file
   @bac_info = BacInfo.first
   @total = 0
   @count = 0

   @payrole.payrole_lines.each do |payrole|
    if payrole.employee.bank == "BAC" && payrole.net_salary.to_i > 0
      @total += payrole.net_salary.to_f
      @count += 1
    end
   end
   
   @total         = @total.round(2)
   @total_amount  = @total.to_s.split(".")[0]
   @total_decimal = "00"

   if  @total.to_s.split(".")[1]
     @total_decimal = @total.to_s.split(".")[1] + ("0" * (2 - @total.to_s.split(".")[1].length))
   end

   respond_to do |format|
      format.xls
    end
  end

  def payrole_detail
    employee = Employee.find(params[:employee_id])
    employee_detail(employee, @payrole)
  end

  def stalls_hours
    if params[:ids] && params[:ids] != ""
      @stalls = Stall.where(id: params[:ids])
    else
      @stalls = Stall.where(active: true).or(Stall.where(id: @role.role_lines.pluck("stall_id").uniq)).order(name: :asc)
    end

    if params[:ajax]
      respond_to do |format|
        format.js
      end
    end
  end

  def budget
    if params[:ids] && params[:ids] != ""
       @budgets = @payrole.budgets.where(stall_id: params[:ids])
    elsif params[:ids] && params[:ids] == ""
      @budgets = @payrole.budgets.order(id: :asc)
    else
      @payrole.budgets.destroy_all
      @payrole.stalls.where(active: true).where.not("name LIKE ?", "%Supervisor%").order(name: :asc).each do |stall|
        @payrole.budgets.new(stall: stall)

        employee_id          = 0
        total_salary         = 0
        total_viatical       = 0 
        total_holidays       = 0 
        total_LPT            = 0 
        total_social_charges = 0 
        old_employee         = 0 
        employee_salary      = 0

        @payrole.role_lines.where(stall_id: stall.id).order(employee_id: :asc).each do |role_line|
          employee = role_line.employee
          if employee_id != role_line.employee_id
            if employee_id == 0
              employee_id  = role_line.employee.id
              old_employee = role_line.employee
            else
              @payrole.budgets.last.budget_lines.new([{ employee: old_employee, salary: employee_salary.round(2) }])
              employee_salary = 0
              employee_id     = role_line.employee.id
              old_employee    = role_line.employee
            end
          end
          has_night =  @payrole.role_lines.joins(:shift).where("name = 'Noche'").length
          employee.calculate_day_salary(role_line, has_night)
          employee.calculate_daily_viatical(role_line)

          total_salary         += employee.day_salary+employee.extra_day_salary+employee.viatical+employee.holiday+role_line.extra_payments.to_f -  role_line.deductions.to_f
          total_LPT            += 0
          total_social_charges += 0

          employee_salary      += employee.day_salary+employee.extra_day_salary+employee.viatical+employee.holiday+role_line.extra_payments.to_f -  role_line.deductions.to_f
        end
        if old_employee != 0
          @payrole.budgets.last.budget_lines.new([{ employee: old_employee, salary: employee_salary.round(2) }])
        end

        @payrole.budgets.last.total_stall = total_salary.round(2)

        quote     = stall.quote 
        salary    = quote.daily_salary.to_f 
        vacations = quote.vacations.to_f 
        holidays  = quote.holidays.to_f 
        budget    = 0 

        quote.requirements.each do |requirement| 

          if requirement.position.name.upcase.exclude? "SUPERVISOR" 
            salary = quote.daily_salary.to_f 

            if quote.night_salary != "" && (requirement.shift.name.upcase.include? "NOCHE")  
              salary = quote.night_salary.to_f 
            end 

            if requirement.position.salary != "" && requirement.position.salary != "0" && requirement.position.salary != nil 
              salary = requirement.position.salary.to_f 
            end 

            required_hours = requirement.hours.to_f 
            shift_hours    = requirement.shift.time.to_f 
            shift_hours    = requirement.position.hours.to_f if (requirement.position.hours != nil && requirement.position.hours != "") 
            extra_hours    = 0 
            extra_hours    = required_hours - shift_hours if required_hours > shift_hours 
            normal_hours   = required_hours - extra_hours 
            day_salary     = salary/30 
            hour_salary    = day_salary/shift_hours 
            extra_salary   = hour_salary*requirement.shift.extra_time_cost.to_f 

            budget += (((normal_hours * hour_salary) + (extra_hours * extra_salary))*15*requirement.workers.to_f*(1+requirement.freeday_worker.to_f)) 
          end 
        end 
        total = (budget + (holidays/2) + (vacations/2)).round(2)

        @payrole.budgets.last.salary         = budget.round(2) 
        @payrole.budgets.last.vacations      = (vacations/2).round(2) 
        @payrole.budgets.last.holidays       = (holidays/2).round(2) 
        @payrole.budgets.last.total_budget   = total 
        @payrole.budgets.last.difference     = (total - total_salary).round(2) 
        @payrole.budgets.last.social_charges = (total*0.4307).round(2) 
        @payrole.budgets.last.cs_difference  = ((total*0.4307) - (total_salary*0.4307)).round(2) 

        total_salary = 0 
      end
      @payrole.save 
      @budgets = @payrole.budgets.order(id: :asc)
    end
    if params[:ajax]
      respond_to do |format|
        format.js
      end
    end
  end

   def budget_detail
    employee = Employee.find(params[:employee_id])
    employee_detail(employee, @payrole)
  end

  def old_budget
    if params[:ids] && params[:ids] != ""
      @budgets = @payrole.budgets.where(stall_id: params[:ids])
    else
      @budgets = @payrole.budgets.order(id: :asc)
    end

    if params[:ajax]
      respond_to do |format|
        format.js
      end
    end
  end

  def old_payrole_detail
    @payrole.stalls.each do |stall|
      stall.employees.each do |employee|
        employee_detail(employee, @payrole) if employee.payrole_details.where(role_id: @payrole.id) != []
      end
    end
  end

  def old_budget_detail
    @employee = Employee.find(params[:employee_id])
  end

  private

    def employee_detail(employee, payrole)
      @employee = employee
      @payrole  = payrole

      @employee.payrole_details.where(role_id: @payrole.id).destroy_all if @employee.payrole_details.where(role_id: @payrole.id)
      @employee.payrole_details.new(role: @payrole)
      lines =  @payrole.role_lines.where(employee: @employee).order(stall_id: :asc, date: :asc)

      if lines

        total_day_salary     = 0
        total_extra_hours    = 0
        total_extra_salary   = 0
        total_extra_payments = 0
        total_deductions     = 0
        total_viatical       = 0
        total_holiday        = 0

        has_night =  lines.joins(:shift).where("name = 'Noche'").length

        lines.each do |line| 

          @employee.calculate_day_salary(line, has_night)
          @employee.calculate_daily_viatical(line)

          total_day_salary     += @employee.day_salary
          total_extra_hours    += @employee.extra_day_hours
          total_extra_salary   += @employee.extra_day_salary
          total_extra_payments += line.extra_payments.to_f
          total_deductions     += line.deductions.to_f
          total_viatical       += @employee.viatical
          total_holiday        += @employee.holiday

          @employee.payrole_details.last.detail_lines.new(stall: line.stall, shift:line.shift)
          @employee.payrole_details.last.detail_lines.last.date                 = line.date
          @employee.payrole_details.last.detail_lines.last.substall             = line.substall
          @employee.payrole_details.last.detail_lines.last.hours                = @employee.normal_day_hours
          @employee.payrole_details.last.detail_lines.last.salary               = @employee.day_salary.round(2)
          @employee.payrole_details.last.detail_lines.last.holiday              = @employee.holiday.round(2)
          @employee.payrole_details.last.detail_lines.last.extra_hours          = @employee.extra_day_hours.round(2)
          @employee.payrole_details.last.detail_lines.last.extra_salary         = @employee.extra_day_salary.round(2)
          @employee.payrole_details.last.detail_lines.last.viatical             = @employee.viatical.round(2)
          @employee.payrole_details.last.detail_lines.last.extra_payment        = line.extra_payments
          @employee.payrole_details.last.detail_lines.last.extra_payment_reason = line.extra_payments_description
          @employee.payrole_details.last.detail_lines.last.deductions           = line.deductions
          @employee.payrole_details.last.detail_lines.last.deductions_reason    = line.deductions_description
          @employee.payrole_details.last.detail_lines.last.comments             = line.comment
        end

        @employee.calculate_payment(lines.length, total_day_salary, total_extra_hours, total_extra_salary, total_viatical, total_extra_payments, total_deductions, total_holiday)
        
        @employee.payrole_details.last.worked_days    = @employee.total_days
        @employee.payrole_details.last.base_salary    = (@employee.total_day_salary + @employee.total_holidays).round(2)
        @employee.payrole_details.last.extra_hours    = @employee.total_extra_hours.round(2)
        @employee.payrole_details.last.extra_salary   = @employee.total_extra_salary.round(2)
        @employee.payrole_details.last.viatical       = @employee.total_viatical.round(2)
        @employee.payrole_details.last.extra_payments = @employee.total_exta_payments.round(2) 
        @employee.payrole_details.last.deductions     = @employee.total_deductions.round(2)
        @employee.payrole_details.last.gross_salary   = (@employee.total_day_salary + @employee.total_holidays + @employee.total_extra_salary + @employee.total_viatical + @employee.total_exta_payments).round(2)
        @employee.payrole_details.last.ccss_deduction = @employee.ccss_deduction.round(2) 
        @employee.payrole_details.last.net_salary     = @employee.net_salary.round(2)
        @employee.save
      end
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :start_date, :end_date, stall_ids: [], role_lines_attributes: [:id, :date, :employee_id, :stall_id, :shift_id, :substall, :comment, :hours, :requirement_justification, :extra_payments, :extra_payments_description, :deductions, :deductions_description, :holiday, :position_id, :_destroy])
    end
end
end
