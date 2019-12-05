class CreateChristmasBonifications < ActiveRecord::Migration[5.2]
  def change
    create_table :christmas_bonifications do |t|
      t.string :from_date
      t.string :to_date
      t.string :total

      t.references :employee, foreign_key: true
      t.timestamps
    end
  end
end
