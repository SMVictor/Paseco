class AddAccountOwnerToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :account_owner, :string
  end
end
