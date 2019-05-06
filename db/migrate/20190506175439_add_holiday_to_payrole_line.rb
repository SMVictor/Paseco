class AddHolidayToPayroleLine < ActiveRecord::Migration[5.2]
  def change
    add_column :payrole_lines, :holidays, :string
  end
end
