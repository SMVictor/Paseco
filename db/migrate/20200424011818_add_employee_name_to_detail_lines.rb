class AddEmployeeNameToDetailLines < ActiveRecord::Migration[5.2]
  def change
    add_column :detail_lines, :employee_name, :string
  end
end
