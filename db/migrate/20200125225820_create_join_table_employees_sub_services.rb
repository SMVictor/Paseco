class CreateJoinTableEmployeesSubServices < ActiveRecord::Migration[5.2]
  def change
    create_join_table :employees, :sub_services do |t|
       t.index [:employee_id, :sub_service_id]
      # t.index [:sub_service_id, :employee_id]
    end
  end
end
