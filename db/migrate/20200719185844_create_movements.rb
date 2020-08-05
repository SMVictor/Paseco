class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.date :start_date
      t.date :end_date
      t.string :affair
      t.string :way
      t.float :amount
      t.string :comment

      t.timestamps
      t.belongs_to :employee, index: true
    end
  end
end
