class RemoveStallFromRequirements < ActiveRecord::Migration[5.2]
  def change
    remove_reference :requirements, :stall
    add_reference :requirements, :quote, index: true, foreign_key: true
  end
end
