class AddExtraPaymentsToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :role_lines, :extra_payments, :string
    add_column :role_lines, :extra_payments_description, :string
    add_column :role_lines, :deductions, :string
    add_column :role_lines, :deductions_description, :string
  end
end
