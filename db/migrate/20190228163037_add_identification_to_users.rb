class AddIdentificationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :identification, :string
  end
end
