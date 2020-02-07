class AddSectorToDetailLines < ActiveRecord::Migration[5.2]
  def change
    add_column :detail_lines, :sector,      :string
    add_column :detail_lines, :sub_service, :string
    add_column :detail_lines, :stall_type,  :string
  end
end
