class CreateSubServices < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_services do |t|
      t.string :name

      t.timestamps
    end
  end
end
