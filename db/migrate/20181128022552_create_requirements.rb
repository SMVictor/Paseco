class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.string :name
      t.string :shifts
      t.string :hours
      t.string :workers

      t.belongs_to :stall, index: true

      t.timestamps
    end
  end
end
