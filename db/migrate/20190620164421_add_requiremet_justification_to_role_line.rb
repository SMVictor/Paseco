class AddRequiremetJustificationToRoleLine < ActiveRecord::Migration[5.2]
  def change
    add_column :role_lines, :requirement_justification, :string
  end
end
