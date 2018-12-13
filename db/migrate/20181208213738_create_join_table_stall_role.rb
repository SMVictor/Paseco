class CreateJoinTableStallRole < ActiveRecord::Migration[5.2]
  def change
    create_join_table :stalls, :roles do |t|
       t.index [:stall_id, :role_id]
      # t.index [:role_id, :stall_id]
    end
  end
end
