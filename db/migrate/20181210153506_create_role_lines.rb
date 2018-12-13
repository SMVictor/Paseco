class CreateRoleLines < ActiveRecord::Migration[5.2]
  def change
    create_table :role_lines do |t|
      t.string :date
      t.string :shift
      t.string :substall
      t.string :extra_hours

      t.belongs_to :role, index: true
      t.belongs_to :employee, index: true
      t.belongs_to :stall, index: true

      t.timestamps
    end
  end
end
