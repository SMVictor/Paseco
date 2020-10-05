class BonusesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
  	employees = Employee.where(active: true)
  	employees.each do |employee|
  	  update_christmas_bonuses(employee)
  	end
  end

  def update_christmas_bonuses(employee)

  	@employee = employee
  	sort_entries

    from = Time.now.year
    to   = Time.now.year
    first_payrole_date = '30/11/2019'

    if @employee.entries
      if @employee.entries && @employee.entries.last && @employee.entries.last.start_date && @employee.entries.last.start_date != "" && @employee.entries.last.start_date.to_date.year >= 2020
        from = @employee.entries.last.start_date.to_date.year
        first_payrole_date = @employee.entries.last.start_date
      end
    end
    (from..to).each do |i|
      @employee.calculate_christmas_bonification(i, first_payrole_date)
    end
  end

  def sort_entries
    position = 0

    while position < @employee.entries.size
      
      start_date       = @employee.entries[position].start_date
      end_date         = @employee.entries[position].end_date
      reason_departure = @employee.entries[position].reason_departure
      document         = @employee.entries[position].document

      had_change = false

      @employee.entries.each_with_index do |entry, index|
       
        if entry.start_date.to_time > start_date.to_time

          @employee.entries[position].start_date       = @employee.entries[index].start_date
          @employee.entries[position].end_date         = @employee.entries[index].end_date
          @employee.entries[position].reason_departure = @employee.entries[index].reason_departure
          @employee.entries[position].document         = @employee.entries[index].document

          @employee.entries[index].start_date       = start_date
          @employee.entries[index].end_date         = end_date
          @employee.entries[index].reason_departure = reason_departure
          @employee.entries[index].document         = document

          had_change = true
          break
        end
      end
      unless had_change
        position += 1
      end
    end
    @employee.save
  end
end