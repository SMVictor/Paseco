class AddTypeToStalls < ActiveRecord::Migration[5.2]
  def change
    add_reference :stalls, :type, foreign_key: true
  end
end
