class CreateChristmasBonificationLines < ActiveRecord::Migration[5.2]
  def change
    create_table :christmas_bonification_lines do |t|
      t.string :base_salary
      t.string :extra_payment
      t.string :viaticals
      t.string :total
      t.string :start_date
      t.string :end_date

      t.references :christmas_bonification, foreign_key: true
      t.timestamps
    end
  end
end
