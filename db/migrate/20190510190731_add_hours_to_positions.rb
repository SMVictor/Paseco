class AddHoursToPositions < ActiveRecord::Migration[5.2]
  def change
    add_column :positions, :hours, :integer
  end
end
