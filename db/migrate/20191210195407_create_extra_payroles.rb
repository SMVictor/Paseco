class CreateExtraPayroles < ActiveRecord::Migration[5.2]
  def change
    create_table :extra_payroles do |t|
      t.string :name
      t.string :from_date
      t.string :to_date

      t.timestamps
    end
  end
end
