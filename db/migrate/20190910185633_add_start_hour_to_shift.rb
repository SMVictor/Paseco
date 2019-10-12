class AddStartHourToShift < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :start_hour, :time
  end
end
