class AddShiftToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_reference :requirements, :shift, foreign_key: true
  end
end
