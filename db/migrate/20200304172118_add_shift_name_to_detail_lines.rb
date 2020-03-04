class AddShiftNameToDetailLines < ActiveRecord::Migration[5.2]
  def change
    add_column :detail_lines, :shift_name, :string
    add_column :detail_lines, :stall_name, :string
  end
end
