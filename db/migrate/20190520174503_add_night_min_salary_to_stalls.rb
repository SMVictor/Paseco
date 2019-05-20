class AddNightMinSalaryToStalls < ActiveRecord::Migration[5.2]
  def change
    add_column :stalls, :night_min_salary, :integer
  end
end
