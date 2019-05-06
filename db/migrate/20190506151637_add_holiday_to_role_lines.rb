class AddHolidayToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :role_lines, :holiday,        :boolean, :default => 0
    add_column :role_lines_copies, :holiday, :boolean, :default => 0
  end
end
