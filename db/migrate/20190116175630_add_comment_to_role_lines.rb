class AddCommentToRoleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :role_lines, :comment, :string
  end
end
