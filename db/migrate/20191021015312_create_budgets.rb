class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.string :total_stall
      t.string :salary
      t.string :vacations
      t.string :holidays
      t.string :total_budget
      t.string :difference
      t.string :social_charges
      t.string :cs_difference

      t.references :stall, foreign_key: true
      t.references :role,  foreign_key: true

      t.timestamps
    end
  end
end
