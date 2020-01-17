class AddSendPayslipsToStalls < ActiveRecord::Migration[5.2]
  def change
    add_column :stalls, :send_payslips, :boolean, default: false
  end
end
