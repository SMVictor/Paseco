class AddPositionToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_reference :role_lines, :position, foreign_key: true
  end
end
