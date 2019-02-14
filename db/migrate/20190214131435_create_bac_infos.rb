class CreateBacInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :bac_infos do |t|
      t.string :plan
      t.string :shipping
      t.string :date
      t.string :concept

      t.timestamps
    end
  end
end
