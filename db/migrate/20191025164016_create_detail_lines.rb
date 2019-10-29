class CreateDetailLines < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_lines do |t|
      t.string :date
      t.string :substall
      t.string :hours
      t.string :salary
      t.string :holiday
      t.string :extra_hours
      t.string :extra_salary
      t.string :viatical
      t.string :extra_payment
      t.string :extra_payment_reason
      t.string :deductions
      t.string :deductions_reason
      t.string :comments

      t.references :stall, foreign_key: true
      t.references :shift, foreign_key: true
      t.references :payrole_detail, foreign_key: true

      t.timestamps
    end
  end
end
