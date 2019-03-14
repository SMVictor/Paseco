class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :start_date
      t.string :end_date
      t.string :reason_departure
      t.string :document

      t.belongs_to :customer, index: true
      t.belongs_to :employee, index: true

      t.timestamps
    end
  end
end
