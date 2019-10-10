class AddStartDayToRequirement < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :start_day, :string
    add_column :requirements, :end_day, :string
  end
end
