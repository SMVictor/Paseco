class Employee < ApplicationRecord
  has_many :role_lines
  has_many :payrole_lines
  has_many :payrole_details
  has_many :entries
  has_many :vacations
  has_many :christmas_bonifications
  has_and_belongs_to_many :sub_services, join_table: :employees_sub_services
  has_and_belongs_to_many :stalls, join_table: :employees_stalls
  has_and_belongs_to_many :positions, join_table: :employees_positions
  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vacations, reject_if: :all_blank, allow_destroy: true

  # PAYROLE

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

  # VACATIONS

  attr_accessor :total_vacations_days 
  attr_accessor :used_vacations_days 
  attr_accessor :available_vacations_days


  def calculate_vacations

    @total_vacations_days     = 0
    @used_vacations_days      = 0
    @available_vacations_days = 0

    start_date = self.entries.last != nil && self.entries.last.start_date != "" ? DateTime.parse(self.entries.last.start_date) : Time.now
    end_date   = self.entries.last != nil && self.entries.last.end_date   != "" ? DateTime.parse(self.entries.last.end_date)   : Time.now

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
      @shift.time       = role_line.position.hours if role_line.position.hours != nil && role_line.position.hours != ""
      @hour_cost        = min_salary.to_f/30/@shift.time.to_f
      @extra_day_hours  = role_line.hours.to_f - @shift.time.to_f if role_line.hours.to_f > @shift.time.to_f && @shift.payment.name != "Normal"
      @normal_day_hours = role_line.hours.to_f - @extra_day_hours
      @day_salary       = @normal_day_hours * @hour_cost
      @extra_day_salary = ((min_salary.to_f/30)/@shift.time.to_f) * @shift.extra_time_cost.to_f * @extra_day_hours

      calculate_holiday(role_line, @shift, min_salary)
    end
    rescue => ex
      logger.error ex.message
    end
  end

  def calculate_daily_viatical role_line
    @viatical = 0
    shift = role_line.shift
    if daily_viatical == "yes" && role_line.position.daily_viatical
      if shift.name == "Libre" || shift.name == "Vacaciones"
        @viatical = role_line.stall.daily_viatical.to_f
      elsif shift.name == "Incapacidad" || shift.name == "Permiso" || shift.name == "Ausente" || shift.name == "Suspendido"
        @viatical = 0
      else
        extra_day_hours  = 0
        normal_day_hours = 0
        extra_day_hours  = role_line.hours.to_f - shift.time.to_f if role_line.hours.to_f > shift.time.to_f
        normal_day_hours = role_line.hours.to_f - extra_day_hours
        @viatical = (role_line.stall.daily_viatical.to_f/shift.time.to_f)*role_line.hours.to_f
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

    ccss_percent  = self.retired ? CcssPayment.first.retired_percentage/100 : CcssPayment.first.percentage/100
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

  def calculate_christmas_bonification(year, date)

    from_date = "01/12/"+(year-1).to_s
    to_date =   "30/11/"+year.to_s
    first_payrole_date = "01/12/"+(year-1).to_s

    if date.to_date > from_date.to_date
      first_payrole_date = date
    end

    @christmas_bonus = 0
    christmas_bonification_lines_counter = 0

    @christmas_bonification = self.christmas_bonifications.where(from_date: from_date).first || ChristmasBonification.new(from_date: from_date, to_date: to_date, employee_id: self.id, bank: self.bank, account: self.account, name: self.name)

    PayroleLine.where(name: self.name).each do |payrole_line|
      if payrole_line.role.start_date.to_date >= first_payrole_date.to_date && payrole_line.role.end_date.to_date <= to_date.to_date && (payrole_line.role.end_date.to_date + 7.days) <= Time.now

        if @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter] == nil

          @christmas_bonification.christmas_bonification_lines.new

          @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].start_date    = payrole_line.role.start_date
          @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].end_date      = payrole_line.role.end_date
          @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].base_salary   = (payrole_line.min_salary.to_f + payrole_line.extra_hours.to_f).round(2)
          @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].extra_payment = payrole_line.extra_payments
          @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].viaticals     = payrole_line.daily_viatical
          @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].total         = (payrole_line.min_salary.to_f + payrole_line.extra_hours.to_f + payrole_line.extra_payments.to_f + payrole_line.daily_viatical.to_f).round(2)

          @christmas_bonification.save
        end
        @christmas_bonus += @christmas_bonification.christmas_bonification_lines[christmas_bonification_lines_counter].total.to_i
        christmas_bonification_lines_counter += 1
      end
    end
     @christmas_bonification.total = @christmas_bonus / 12
     @christmas_bonification.save
  end
  def calculate_holiday(role_line, shift, min_salary)

    holidays = Holiday.all

    start_date    = (role_line.date.split("/")[1] + "/" + role_line.date.split("/")[0] + "/" + role_line.date.split("/")[2]).to_time + (role_line.shift.start_hour.hour * 3600)
    end_date      = start_date + (role_line.hours.to_f * 3600)

    is_start_date_holiday = false
    is_end_date_holiday   = false

    holidays.each do |holiday|
      next_holiday = (holiday.date.split("/")[1] + "/" + holiday.date.split("/")[0] + "/" + holiday.date.split("/")[2]).to_time
      if start_date.strftime("%Y-%d-%m") == next_holiday.strftime("%Y-%d-%m")
        is_start_date_holiday = true
      end
      if end_date.strftime("%Y-%d-%m") == next_holiday.strftime("%Y-%d-%m")
        is_end_date_holiday = true
      end
    end

    if is_start_date_holiday
      if is_end_date_holiday
        #Feriado Completo
        @holiday  = ((1/shift.time.to_f)*role_line.hours.to_f) * (min_salary.to_f/30)
        @viatical = @viatical * 2
      else
        #Medio feriado después
        end_holiday = end_date - ((end_date.hour * 3600)-1)

        @holiday  =  ((1/shift.time.to_f)*((end_holiday - start_date)/3600)) * (min_salary.to_f/30)
        @viatical += (role_line.stall.daily_viatical.to_f/shift.time.to_f)*((end_holiday - start_date)/3600)
      end
    elsif is_end_date_holiday
      #Medio feriado antes
      start_holiday = end_date - end_date.hour * 3600
      @holiday  =  ((1/shift.time.to_f)*((end_date - start_holiday)/3600)) * (min_salary.to_f/30)
      @viatical += (role_line.stall.daily_viatical.to_f/shift.time.to_f)*((end_date - start_holiday)/3600)
    else
      #No hay feriado
      @holiday = 0
    end
  end
end