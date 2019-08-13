class CreateVacations < ActiveRecord::Migration[5.2]
  def change
    create_table :vacations do |t|
      t.string :start_date
      t.string :end_date
      t.string :requested_days
      t.string :included_freedays

      t.belongs_to :employee, index: true, foreign_key: true

      t.timestamps
    end
  end
end
