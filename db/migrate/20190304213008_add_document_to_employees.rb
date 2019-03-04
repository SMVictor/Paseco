class AddDocumentToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :document, :string
  end
end
