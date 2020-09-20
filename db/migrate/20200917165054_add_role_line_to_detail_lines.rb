class AddRoleLineToDetailLines < ActiveRecord::Migration[5.2]
  def change
    add_reference :detail_lines, :role_line, foreign_key: true
  end
end
