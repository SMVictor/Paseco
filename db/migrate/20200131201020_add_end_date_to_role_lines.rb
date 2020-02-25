class AddEndDateToRoleLines < ActiveRecord::Migration[5.2]
  def change
  	add_column :role_lines, :start_date, :string
    add_column :role_lines, :start_hour, :time
    add_column :role_lines, :end_date,   :string
    add_column :role_lines, :end_hour,   :time
  end
end
