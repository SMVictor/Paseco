class AddBankToPayroleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :payrole_lines, :bank, :string
  end
end
