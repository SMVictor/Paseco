class AddServiceToDetailLines < ActiveRecord::Migration[5.2]
  def change
    add_column :detail_lines, :service, :string
  end
end
