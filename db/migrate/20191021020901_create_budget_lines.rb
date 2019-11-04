class CreateBudgetLines < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_lines do |t|
      t.string :salary

      t.references :budget, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
