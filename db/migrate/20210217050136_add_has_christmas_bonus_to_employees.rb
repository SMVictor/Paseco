class AddHasChristmasBonusToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :has_christmas_bonus, :boolean, :default => true
  end
end
