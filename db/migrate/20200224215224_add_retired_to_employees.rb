class AddRetiredToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :retired, :boolean, default: false
  end
end
