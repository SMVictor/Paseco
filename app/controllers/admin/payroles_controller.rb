module Admin
class PayrolesController < ApplicationController

  layout 'admin'
  
  before_action :set_payrole, only: [:show]

  def index
    @payroles = Role.all.order(start_date: :desc)
  end

  def show

    @ccss_percent = 0.1035
    @ccss_amount = 12500

    @employees = Employee.all
    @employees.each do |employee|
      if employee.stalls.size == 1
        regular_employess_payrole(employee)
      else
        iregular_employess_payrole(employee)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payrole
      @payrole = Role.find(params[:id])
    end

    def regular_employess_payrole(employee)
      @role_lines = @payrole.role_lines.where(employee: employee)

      @min_salary = 0
      @extra_salary = 0
      @viatical = 0

      @role_lines.each do |role_line|
        @stall = role_line.stall
        @shift = role_line.shift
        @hour_cost = @stall.min_salary.to_f/@shift.time.to_f/30 if @shift and @stall

        @normal_hours = 0
        @extra_hours = 0

        @extra_hours = role_line.hours.to_f - @shift.time.to_f if role_line.hours.to_f > @shift.time.to_f
        
        @normal_hours = role_line.hours.to_f - @extra_hours

        @min_salary += @normal_hours * @hour_cost

        @extra_salary += ((@stall.min_salary.to_f/30)/8) * @shift.extra_time_cost.to_f * @extra_hours

        if employee.daily_viatical == 'yes'
          @viatical += @stall.daily_viatical.to_f
        end

      end
      @payrole_line = @payrole.payrole_lines.where(employee_id: employee.id)[0]
      if @payrole_line == nil
        @payrole_line = @payrole.payrole_lines.create([{ min_salary: '0', extra_hours: '0', daily_viatical: '0', ccss_deduction: '0', extra_payments: '0', deductions: '0', net_salary: '0', employee_id: employee.id }])[0]
      end
      @payrole_line.min_salary = @min_salary.round(2)
      @payrole_line.extra_hours = @extra_salary.round(2)
      @payrole_line.daily_viatical = @viatical.round(2)
      @gross_salary = (@min_salary + @extra_salary).round(2)

      if employee.social_security == "Porcentaje"
        if employee.ccss_type == "yes"
          @payrole_line.ccss_deduction = (@gross_salary * @ccss_percent).round(2)
          @payrole_line.net_salary = (@gross_salary - (@gross_salary * @ccss_percent) + @viatical).round(0)
        else
          @payrole_line.ccss_deduction = (@payrole_line.min_salary.to_f * @ccss_percent).round(2)
          @payrole_line.net_salary = (@gross_salary - (@payrole_line.min_salary.to_f * @ccss_percent) + @viatical).round(0)
        end
      else
        @payrole_line.ccss_deduction = @ccss_amount
        @payrole_line.net_salary = (@gross_salary - @ccss_amount + @viatical).round(0)
      end
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

      @role_lines.each do |role_line|

        @stall = role_line.stall

        @min_salary += @day_cost

        if employee.daily_viatical == 'yes'
          @viatical += @stall.daily_viatical.to_f
        end
      end

      @gross_salary = (@min_salary + @extra_salary).round(2)

      if employee.social_security == "Porcentaje"
        if employee.ccss_type == "yes"
          @ccss_deduction = (@gross_salary * @ccss_percent).round(2)
          @net_salary = (@gross_salary - @gross_salary * @ccss_percent + @viatical).round(0)
        else
          @ccss_deduction = (@min_salary.to_f * @ccss_percent).round(2)
          @net_salary = (@gross_salary - @min_salary.to_f * @ccss_percent + @viatical).round(0)
        end
      else
        @ccss_deduction = @ccss_amount
        @net_salary = (@gross_salary - @ccss_amount + @viatical).round(0)
      end

      @payrole_line.min_salary     = @min_salary.round(2)
      @payrole_line.extra_hours    = 0
      @payrole_line.daily_viatical = @viatical.round(2)
      @payrole_line.ccss_deduction = @ccss_deduction
      @payrole_line.deductions     = 0
      @payrole_line.extra_payments = 0
      @payrole_line.net_salary     = @net_salary
      @payrole_line.save
    end
end
end