class AddFreedayWorkersToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :freeday_worker, :string
  end
end
