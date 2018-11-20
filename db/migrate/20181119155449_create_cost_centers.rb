class CreateCostCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :cost_centers do |t|
      t.string :name
      t.string :province
      t.string :canton
      t.string :distric
      t.string :others

      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
