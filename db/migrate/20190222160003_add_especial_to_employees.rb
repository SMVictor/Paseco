class AddEspecialToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :active,  :boolean, :default => 1
  end
end
