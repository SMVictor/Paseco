class RemovePaymentFromStalls < ActiveRecord::Migration[5.2]
  def change
    remove_reference :stalls, :payment
  end
end
