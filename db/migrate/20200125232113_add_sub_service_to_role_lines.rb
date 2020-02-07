class AddSubServiceToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_reference :role_lines, :sub_service, foreign_key: true
  end
end
