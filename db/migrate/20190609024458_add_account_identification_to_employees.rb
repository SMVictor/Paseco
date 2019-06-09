class AddAccountIdentificationToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :account_identification, :string
  end
end
