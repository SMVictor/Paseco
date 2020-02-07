class RemoveSubServiceFromEmployees < ActiveRecord::Migration[5.2]
  def change
    remove_column :employees, :sub_service_id, :integer
  end
end
