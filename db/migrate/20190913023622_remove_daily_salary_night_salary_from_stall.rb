class RemoveDailySalaryNightSalaryFromStall < ActiveRecord::Migration[5.2]

  def change
    remove_column :stalls, :night_min_salary, :string
    remove_column :stalls, :min_salary, :string
  end
end
