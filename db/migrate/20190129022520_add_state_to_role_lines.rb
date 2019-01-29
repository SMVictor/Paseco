class AddStateToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :role_lines, :state, :string
  end
end
