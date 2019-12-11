class Role < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines, dependent: :delete_all
  has_many :payrole_lines,  dependent: :delete_all
  has_many :budgets
  has_many :payrole_details
  accepts_nested_attributes_for :role_lines, reject_if: :all_blank, allow_destroy: true

  attr_accessor :file

  def self.import(file, name)

    role_id = Role.where(name: name).first.id
    role = Role.where(name: name).first
    spreadsheet = open_spreadsheet(file)
    count = 0

    (2..spreadsheet.last_row).each do |i|

      row = spreadsheet.row(i)

      name = row[0]
      payrole_line = PayroleLine.where(name: name, role_id: role_id).first || PayroleLine.new
      row[12].gsub!('-', '')

      payrole_line.name            = row[0]
      payrole_line.net_salary      = row[3]
      payrole_line.num_worked_days = row[2].round(2)
      payrole_line.min_salary      = row[1]
      payrole_line.holidays        = row[4]
      payrole_line.daily_viatical  = row[5]
      payrole_line.extra_payments  = row[6]
      payrole_line.ccss_type       = row[7]
      payrole_line.social_security = row[8]
      payrole_line.ccss_deduction  = row[9]
      payrole_line.deductions      = row[10]
      payrole_line.bank            = row[11]
      payrole_line.account         = row[12]
      payrole_line.role_id         = role_id
      payrole_line.num_extra_hours = 0
      payrole_line.extra_hours     = 0
      payrole_line.save!

      bonus = ChristmasBonification.joins(:employee).where(employees: {name: name}).where(from_date: '01/12/2018').first
      if bonus
        line = bonus.christmas_bonification_lines.where(start_date: role.start_date).first
        line.base_salary = row[1]
        line.save
      end
      count += 1
    end
    return count
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".xls" then Roo::Excel.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end