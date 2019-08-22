class AddAccountToPayroleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :payrole_lines, :account, :string
  end
end
