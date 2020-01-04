class AddSubServiceToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :sub_service, foreign_key: true
  end
end
