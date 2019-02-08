class AddNumExtraHoursToPayroleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :payrole_lines, :num_extra_hours, :string
    add_column :payrole_lines, :num_worked_days, :string
  end
end
