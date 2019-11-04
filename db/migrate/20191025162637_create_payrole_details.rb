class CreatePayroleDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :payrole_details do |t|
      t.string :worked_days
      t.string :base_salary
      t.string :extra_hours
      t.string :extra_salary
      t.string :viatical
      t.string :extra_payments
      t.string :deductions
      t.string :gross_salary
      t.string :ccss_deduction
      t.string :net_salary

      t.references :role, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
