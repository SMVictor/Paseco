class CreateWorkRoleLines < ActiveRecord::Migration[5.2]
  def change
    create_table :work_role_lines do |t|
      t.date :date
      t.string :sub_stall

    t.belongs_to :work_role,     index: true
	  t.belongs_to :employee, index: true
	  t.belongs_to :stall,    index: true
	  t.belongs_to :shift,    index: true

      t.timestamps
    end
  end
end
