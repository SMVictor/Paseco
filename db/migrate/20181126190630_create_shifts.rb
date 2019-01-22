class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :name
      t.string :time
      t.string :cost
      t.string :extra_time_cost

      t.belongs_to :payment, index: true

      t.timestamps
    end
  end
end
