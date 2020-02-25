class AddRetiredPercentageToCcssPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :ccss_payments, :retired_percentage, :float
  end
end
