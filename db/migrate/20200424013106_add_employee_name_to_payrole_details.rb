class AddEmployeeNameToPayroleDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :payrole_details, :employee_name, :string
  end
end
