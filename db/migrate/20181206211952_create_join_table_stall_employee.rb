class CreateJoinTableStallEmployee < ActiveRecord::Migration[5.2]
  def change
    create_join_table :stalls, :employees do |t|
      t.index [:stall_id, :employee_id]
      # t.index [:employee_id, :stall_id]
    end
  end
end
