class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :business_name
      t.string :tradename
      t.string :representativr_id
      t.string :representative_name
      t.string :legal_document
      t.string :legal_document
      t.string :phone_number
      t.string :email
      t.string :contact
      t.string :payment_method
      t.string :payment_conditions

      t.timestamps
    end
  end
end
