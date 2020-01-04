class AddSectorToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :sector, foreign_key: true
  end
end
