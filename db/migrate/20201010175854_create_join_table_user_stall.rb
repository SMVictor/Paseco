class CreateJoinTableUserStall < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :stalls do |t|
       t.index [:user_id, :stall_id]
      # t.index [:stall_id, :user_id]
    end
  end
end
