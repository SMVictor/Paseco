class AddPeriodToVacations < ActiveRecord::Migration[5.2]
  def change
    add_column :vacations, :period, :string
  end
end
