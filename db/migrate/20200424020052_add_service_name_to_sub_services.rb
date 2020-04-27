class AddServiceNameToSubServices < ActiveRecord::Migration[5.2]
  def change
    add_column :sub_services, :service_name, :string
  end
end
