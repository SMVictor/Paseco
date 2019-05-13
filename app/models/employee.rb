class Employee < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines
  has_many :payrole_lines
  has_many :entries
  has_and_belongs_to_many :positions, join_table: :employees_positions
  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true

  attr_accessor :day_salary
  attr_accessor :normal_day_hours
  attr_accessor :extra_day_hours
  attr_accessor :extra_day_salary
  attr_accessor :viatical
  attr_accessor :holiday

  attr_accessor :total_days
  attr_accessor :total_day_salary
  attr_accessor :total_extra_hours
  attr_accessor :total_extra_salary
  attr_accessor :total_viatical
  attr_accessor :total_holidays
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
    @holiday          = 0

    if role_line.position.name == "Oficial"
      min_salary = @stall.min_salary
    else
      min_salary  = role_line.position.salary.to_f
    end
    if @shift.name == "Libre"
      @day_salary = min_salary.to_f/30
    elsif @shift.name == "Incapacidad" || @shift.name == "Permiso"
      @day_salary = 0
    else
      @normal_day_hours = 0
      @extra_day_hours  = 0
      @shift.time       = role_line.position.hours if role_line.position.hours
      @hour_cost        = min_salary.to_f/30/@shift.time.to_f
      @extra_day_hours  = role_line.hours.to_f - @shift.time.to_f if role_line.hours.to_f > @shift.time.to_f
      @normal_day_hours = role_line.hours.to_f - @extra_day_hours
      @day_salary       = @normal_day_hours * @hour_cost
      @extra_day_salary = ((min_salary.to_f/30)/@shift.time.to_f) * @shift.extra_time_cost.to_f * @extra_day_hours

      if role_line.holiday
        @holiday = ((1/@shift.time.to_f)*role_line.hours.to_f) * (min_salary.to_f/30)
      end
    end
  end

  def calculate_daily_viatical role_line
  	@viatical = 0
    shift = role_line.shift

  	if daily_viatical == "yes" && role_line.position.daily_viatical
  	  if role_line.shift.name == "Libre"
  	  	@viatical = role_line.stall.daily_viatical.to_f
  	  elsif role_line.shift.name == "Incapacidad" || role_line.shift.name == "Permiso"
  	  	@viatical = 0
  	  else
        extra_day_hours  = 0
        normal_day_hours = 0
        extra_day_hours  = role_line.hours.to_f - shift.time.to_f if role_line.hours.to_f > shift.time.to_f
        normal_day_hours = role_line.hours.to_f - extra_day_hours
  	  	@viatical = (role_line.stall.daily_viatical.to_f/role_line.shift.time.to_f)*normal_day_hours
  	  end
  	else
  	  @viatical = 0
  	end
  end

  def calculate_payment(total_days, total_day_salary, total_extra_hours, total_extra_salary, total_viatical, total_exta_payments, total_deductions, total_holidays)
  	
  	@total_days          = total_days
  	@total_day_salary    = total_day_salary
  	@total_extra_hours   = total_extra_hours
  	@total_extra_salary  = total_extra_salary
  	@total_viatical      = total_viatical
  	@total_exta_payments = total_exta_payments
  	@total_deductions    = total_deductions
    @total_holidays      = total_holidays

  	ccss_percent  = CcssPayment.first.percentage/100
    ccss_amount   = CcssPayment.first.amount

  	@gross_salary   = total_day_salary + total_extra_salary + total_viatical + total_holidays

  	if social_security == "Porcentaje"
  	  if ccss_type == "yes"
        @ccss_deduction = (@gross_salary * ccss_percent).round(2)
        @net_salary     = (@gross_salary - @gross_salary * ccss_percent + total_exta_payments - total_deductions).round(0)
      else
        @ccss_deduction = ((total_day_salary + total_holidays) * ccss_percent).round(2)
        @net_salary     = (@gross_salary - ((total_day_salary + total_holidays) * ccss_percent) + total_exta_payments - total_deductions).round(0)
      end
    elsif social_security == "Monto" 
      @ccss_deduction = ccss_amount
      @net_salary = (@gross_salary - ccss_amount + total_exta_payments - total_deductions).round(0)
    else
      @net_salary = (@gross_salary + total_exta_payments - total_deductions).round(0)
    end
  end
end