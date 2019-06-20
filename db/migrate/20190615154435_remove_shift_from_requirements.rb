class RemoveShiftFromRequirements < ActiveRecord::Migration[5.2]
  def change
    remove_column :requirements, :shifts, :string
  end
end
