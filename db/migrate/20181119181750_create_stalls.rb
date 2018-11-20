class CreateStalls < ActiveRecord::Migration[5.2]
  def change
    create_table :stalls do |t|
      t.string :name
      t.string :description

      t.belongs_to :cost_center, index: true

      t.timestamps
    end
  end
end
