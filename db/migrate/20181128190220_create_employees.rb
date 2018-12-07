class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :gender
      t.string :id_type
      t.string :identification
      t.string :birthday
      t.integer :role
      t.string :start_date
      t.string :end_date

      t.string :province
      t.string :canton
      t.string :district
      t.string :other
      t.string :phone
      t.string :phone_1
      t.string :emergency_contact
      t.string :emergency_number

      t.string :payment_method
      t.string :bank
      t.string :account
      t.string :ccss_number
      t.string :social_security

      t.timestamps
    end
  end
end
