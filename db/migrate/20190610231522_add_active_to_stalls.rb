class AddActiveToStalls < ActiveRecord::Migration[5.2]
  def change
    add_column :stalls, :active, :boolean, :default => 1
  end
end
