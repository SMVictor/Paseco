class Employee < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines
  has_many :payrole_lines
  has_many :entries
  belongs_to :position

  enum position: [:"Administrador", :"Conserje", :"Mantenimiento", :"Oficial_1", :"Oficial_2", :"Oficial_3", :"Supervisor_1", :"Supervisor_2"]
  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true

  attr_accessor :day_salary
  attr_accessor :normal_day_hours
  attr_accessor :extra_day_hours
  attr_accessor :extra_day_salary
  attr_accessor :viatical

  attr_accessor :total_days
  attr_accessor :total_day_salary
  attr_accessor :total_extra_hours
  attr_accessor :total_extra_salary
  attr_accessor :total_viatical
  attr_accessor :total_exta_payments
  attr_accessor :total_deductions
  attr_accessor :ccss_deduction
  attr_accessor :net_salary  


  def calculate_day_salary role_line
  	@stall = role_line.stall
    @shift = role_line.shift

    @normal_day_hours = 0
  	@day_salary       = 0
  	@extra_day_hours  = 0
  	@extra_day_salary = 0

  	if special
  	  @day_salary = position.salary.to_f/30  if @shift.name != "Incapacidad"
  	else
      if @shift.name == "Libre"
        @day_salary = @stall.min_salary.to_f/30
      elsif @shift.name == "Incapacidad"
        @day_salary = 0
      else
      	@normal_day_hours = 0
        @extra_day_hours  = 0
        @hour_cost        = @stall.min_salary.to_f/30/@shift.time.to_f
        @extra_day_hours  = role_line.hours.to_f - @shift.time.to_f if role_line.hours.to_f > @shift.time.to_f
        @normal_day_hours = role_line.hours.to_f - @extra_day_hours
        @day_salary       = @normal_day_hours * @hour_cost
        @extra_day_salary = ((@stall.min_salary.to_f/30)/@shift.time.to_f) * @shift.extra_time_cost.to_f * @extra_day_hours
      end
  	end
  end

  def calculate_daily_viatical role_line
  	@viatical = 0
  	if daily_viatical == "yes"
  	  if role_line.shift.name == "Libre"
  	  	@viatical = role_line.stall.daily_viatical.to_f
  	  elsif role_line.shift.name == "Incapacidad"
  	  	@viatical = 0
  	  else
  	  	@viatical = (role_line.stall.daily_viatical.to_f/role_line.shift.time.to_f)*role_line.hours.to_f
  	  end
  	else
  	  @viatical = 0
  	end
  end

  def calculate_payment(total_days, total_day_salary, total_extra_hours, total_extra_salary, total_viatical, total_exta_payments, total_deductions)
  	
  	@total_days          = total_days
  	@total_day_salary    = total_day_salary
  	@total_extra_hours   = total_extra_hours
  	@total_extra_salary  = total_extra_salary
  	@total_viatical      = total_viatical
  	@total_exta_payments = total_exta_payments
  	@total_deductions    = total_deductions

  	ccss_percent  = CcssPayment.first.percentage/100
    ccss_amount   = CcssPayment.first.amount

  	@gross_salary   = total_day_salary + total_extra_salary

  	if social_security == "Porcentaje"
  	  if ccss_type == "yes"
          @ccss_deduction = (@gross_salary * ccss_percent).round(2)
          @net_salary     = (@gross_salary - @gross_salary * ccss_percent + total_viatical + total_exta_payments - total_deductions).round(0)
        else
          @ccss_deduction = (total_day_salary * ccss_percent).round(2)
          @net_salary     = (@gross_salary - total_day_salary * ccss_percent + total_viatical + total_exta_payments - total_deductions).round(0)
        end
      else
        @ccss_deduction = ccss_amount
        @net_salary = (@gross_salary - ccss_amount + total_viatical + total_exta_payments - total_deductions).round(0)
      end
  end
end