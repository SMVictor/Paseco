class AddServiceToSubServices < ActiveRecord::Migration[5.2]
  def change
    add_reference :sub_services, :service, foreign_key: true
  end
end
