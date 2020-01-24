class AddDateToVacations < ActiveRecord::Migration[5.2]
  def change
    add_column :vacations, :date, :string
  end
end
