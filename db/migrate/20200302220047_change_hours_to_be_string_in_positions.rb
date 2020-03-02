class ChangeHoursToBeStringInPositions < ActiveRecord::Migration[5.2]
  def change
  	change_column :positions, :hours, :string
  end
end
