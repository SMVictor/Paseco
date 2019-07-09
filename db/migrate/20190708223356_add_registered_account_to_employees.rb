class AddRegisteredAccountToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :registered_account, :boolean, :default => 0
  end
end
