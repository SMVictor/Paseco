class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :province
      t.string :canton
      t.string :district
    end
  end
end
