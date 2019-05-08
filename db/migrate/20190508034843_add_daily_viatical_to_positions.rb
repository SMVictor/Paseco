class AddDailyViaticalToPositions < ActiveRecord::Migration[5.2]
  def change
    add_column :positions, :daily_viatical, :boolean
  end
end
