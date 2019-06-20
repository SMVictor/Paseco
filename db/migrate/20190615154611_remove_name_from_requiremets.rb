class RemoveNameFromRequiremets < ActiveRecord::Migration[5.2]
  def change
    remove_column :requirements, :name, :string
  end
end
