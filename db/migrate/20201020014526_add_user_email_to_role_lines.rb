class AddUserEmailToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :role_lines, :user_email, :string
  end
end
