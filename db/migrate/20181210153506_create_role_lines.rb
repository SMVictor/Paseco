class CreateRoleLines < ActiveRecord::Migration[5.2]
  def change
    create_table :role_lines do |t|
      t.string :date
      t.string :substall
      t.string :hours

      t.belongs_to :role, index: true
      t.belongs_to :employee, index: true
      t.belongs_to :stall, index: true
      t.belongs_to :shift, index: true

      t.timestamps
    end
  end
end
