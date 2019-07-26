class AddAreaToPositions < ActiveRecord::Migration[5.2]
  def change
    add_reference :positions, :area, foreign_key: true
  end
end
