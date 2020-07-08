class CreateDisabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :disabilities do |t|
      t.date :start_date
      t.date :end_date

      t.belongs_to :employee, index: true
      t.timestamps
    end
  end
end
