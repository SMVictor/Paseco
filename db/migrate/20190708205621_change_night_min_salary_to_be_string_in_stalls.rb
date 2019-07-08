class ChangeNightMinSalaryToBeStringInStalls < ActiveRecord::Migration[5.2]
  def change
  	change_column :stalls, :night_min_salary, :string
  end
end
