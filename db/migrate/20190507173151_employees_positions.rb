class EmployeesPositions < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :employees, :positions do |t|
       t.index [:employee_id, :position_id]
      # t.index [:student_id, :user_id]
    end
  end
end
