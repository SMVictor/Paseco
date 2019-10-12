class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.integer :number
      t.string :type
      t.string :institution
      t.string :procedure_number
      t.string :procedure_description
      t.string :officers
      t.string :holidays
      t.string :vacations
      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
