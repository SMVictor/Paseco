class AddEmployeeConceptToBncrInfos < ActiveRecord::Migration[5.2]
  def change
    add_column :bncr_infos, :employee_concept, :string
  end
end
