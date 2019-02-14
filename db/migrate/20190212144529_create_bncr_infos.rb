class CreateBncrInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :bncr_infos do |t|
      t.string :date
      t.string :company
      t.string :transfer_type
      t.string :consecutive
      t.string :concept
      t.string :account

      t.timestamps
    end
  end
end
