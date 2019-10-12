class CreateQuoteCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :quote_copies do |t|
      t.string :institution
      t.string :procedure_number
      t.string :procedure_description
      t.integer :payment_id
      t.string :daily_salary
      t.string :night_salary

      t.timestamps
    end
  end
end
