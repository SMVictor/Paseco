class CreateRoleLinesCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :role_lines_copies do |t|

      t.string  :date
      t.string  :substall
      t.string  :hours
      t.integer :employee_id
      t.integer :shift_id
      t.integer :stall_id
      t.integer :role_id
      t.string  :comment
      t.string  :action

      t.belongs_to :role_line, index: true

      t.timestamps
    end
  end
end
