class CreateCcssPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :ccss_payments do |t|
      t.float :percentage
      t.float :amount

      t.timestamps
    end
  end
end
