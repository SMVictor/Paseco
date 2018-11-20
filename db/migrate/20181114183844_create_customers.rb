class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      
      t.string :business_name
      t.string :tradename
      t.string :representative_id
      t.string :representative_name
      t.string :legal_document
      t.string :start_date
      t.string :end_date

      t.string :contact
      t.string :email
      t.string :email_1
      t.string :email_2
      t.string :phone_number
      t.string :phone_number_1

      t.string :payment_method
      t.string :payment_conditions

      t.timestamps
    end
  end
end
