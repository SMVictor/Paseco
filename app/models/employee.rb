class Employee < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines
  has_many :payrole_lines
  has_many :payrole_details
  has_many :entries
  has_many :vacations
  has_and_belongs_to_many :positions, join_table: :employees_positions
  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vacations, reject_if: :all_blank, allow_destroy: true

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

  attr_accessor :total_vacations_days 
  attr_accessor :used_vacations_days 
  attr_accessor :available_vacations_days 


  def calculate_vacations

    @total_vacations_days     = 0
    @used_vacations_days      = 0
    @available_vacations_days = 0

    start_date = DateTime.parse(self.entries.last.start_date)
    end_date   = self.entries.last.end_date != ""? DateTime.parse(self.entries.last.end_date) : Time.now

    total_worked_months = -1

    while start_date <= end_date
      total_worked_months += 1
      start_date += 1.months
    end

    worked_years  = 0
    worked_months = 0  

    worked_years  = total_worked_months/12
    worked_months = total_worked_months%12

    @total_vacations_days = worked_years * 14 + worked_months

    self.vacations.each do |vacation|
      @used_vacations_days += vacation.requested_days.to_i
    end

    @available_vacations_days = @total_vacations_days - @used_vacations_days

  end 

  def calculate_day_salary(role_line, has_night)
    begin
  	@stall = role_line.stall
    @shift = role_line.shift

    @normal_day_hours = 0
  	@day_salary       = 0
  	@extra_day_hours  = 0
  	@extra_day_salary = 0
    @holiday          = 0

    if role_line.position.name == "Oficial"
      if role_line.shift.name == "Noche" && @stall.quote.night_salary != nil && @stall.quote.night_salary != ""
        @stall.quote.daily_salary = @stall.quote.night_salary
      elsif role_line.shift.name == "Libre" && @stall.quote.night_salary != nil && @stall.quote.night_salary != "" && has_night != 0
        @stall.quote.daily_salary = @stall.quote.night_salary
      else
      end
      min_salary = @stall.quote.daily_salary
    else
      min_salary  = role_line.position.salary
    end

    if @shift.name == "Libre" || @shift.name == "Vacaciones"
      @day_salary = min_salary.to_f/30
    elsif @shift.name == "Incapacidad" || @shift.name == "Permiso" || @shift.name == "Ausente" || @shift.name == "Suspendido"
      @day_salary = 0
    else
      @normal_day_hours = 0
      @extra_day_hours  = 0
      @shift.time       = role_line.position.hours if role_line.position.hours
      @hour_cost        = min_salary.to_f/30/@shift.time.to_f
      @extra_day_hours  = role_line.hours.to_f - @shift.time.to_f if role_line.hours.to_f > @shift.time.to_f && @shift.payment.name != "Normal"
      @normal_day_hours = role_line.hours.to_f - @extra_day_hours
      @day_salary       = @normal_day_hours * @hour_cost
      @extra_day_salary = ((min_salary.to_f/30)/@shift.time.to_f) * @shift.extra_time_cost.to_f * @extra_day_hours

      if role_line.holiday
        @holiday = ((1/@shift.time.to_f)*role_line.hours.to_f) * (min_salary.to_f/30)
      end
    end
    rescue => ex
      logger.error ex.message
    end
  end

  def calculate_daily_viatical role_line
  	@viatical = 0
    shift = role_line.shift

  	if daily_viatical == "yes" && role_line.position.daily_viatical
  	  if role_line.shift.name == "Libre" || @shift.name == "Vacaciones"
  	  	@viatical = role_line.stall.daily_viatical.to_f
  	  elsif role_line.shift.name == "Incapacidad" || role_line.shift.name == "Permiso" || @shift.name == "Ausente" || @shift.name == "Suspendido"
  	  	@viatical = 0
  	  else
        extra_day_hours  = 0
        normal_day_hours = 0
        extra_day_hours  = role_line.hours.to_f - shift.time.to_f if role_line.hours.to_f > shift.time.to_f
        normal_day_hours = role_line.hours.to_f - extra_day_hours
  	  	@viatical = (role_line.stall.daily_viatical.to_f/role_line.shift.time.to_f)*role_line.hours.to_f
        @viatical = @viatical * 2 if role_line.holiday
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
        @net_salary     = (@gross_salary - @ccss_deduction + total_exta_payments - total_deductions).round(2)
      else
        @ccss_deduction = ((total_day_salary + total_extra_salary + total_holidays) * ccss_percent).round(2)
        @net_salary     = (@gross_salary - @ccss_deduction + total_exta_payments - total_deductions).round(2)
      end
    elsif social_security == "Monto" 
      @ccss_deduction = ccss_amount
      @net_salary = (@gross_salary - ccss_amount + total_exta_payments - total_deductions).round(2)
    else
      @ccss_deduction = 0
      @net_salary = (@gross_salary + total_exta_payments - total_deductions).round(2)
    end
  end

  def formated_account
    if self.bank == "BAC" || self.account.length != 15
      formated_account = self.account
    else
      formated_account = self.account[0..2]+"-"+self.account[3..4]+"-"+self.account[5..7]+"-"+self.account[8..13]+"-"+self.account[14]
    end
  end
end