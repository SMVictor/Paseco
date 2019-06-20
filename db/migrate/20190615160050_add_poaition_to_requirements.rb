class AddPoaitionToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_reference :requirements, :position, foreign_key: true
  end
end
