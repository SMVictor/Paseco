class AddIdentificationToPayroleLines < ActiveRecord::Migration[5.2]
  def change
    add_column :payrole_lines, :social_security, :string
    add_column :payrole_lines, :ccss_type, :string
    add_column :payrole_lines, :name, :string
  end
end
