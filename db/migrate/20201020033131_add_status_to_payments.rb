class AddStatusToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :status, :string, default: 'Activo'
  end
end
