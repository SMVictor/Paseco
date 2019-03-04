class AddDocumentToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :document, :string
  end
end
