class CreatePayroleLines < ActiveRecord::Migration[5.2]
  def change
    create_table :payrole_lines do |t|
      t.string :min_salary
      t.string :extra_hours
      t.string :daily_viatical
      t.string :ccss_deduction
      t.string :net_salary
      t.string :extra_payments
      t.string :deductions

      t.belongs_to :role, index: true
      t.belongs_to :employee, index: true

      t.timestamps
    end
  end
end
