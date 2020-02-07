class AddActiveToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :active, :boolean, default: true
  end
end
