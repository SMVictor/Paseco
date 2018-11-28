class CreateStalls < ActiveRecord::Migration[5.2]
  def change
    create_table :stalls do |t|
      t.string :name
      t.string :description
      t.string :province
      t.string :canton
      t.string :district
      t.string :other
      t.string :ccss_percentage
      
      t.string :daily_viatical
      t.string :performance_extras
      t.string :daily_brands
      t.string :extra_shift


      t.belongs_to :customer, index: true
      t.belongs_to :payment, index: true

      t.timestamps
    end
  end
end
