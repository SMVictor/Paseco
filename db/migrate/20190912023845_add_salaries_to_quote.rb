class AddSalariesToQuote < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :daily_salary, :string
    add_column :quotes, :night_salary, :string
  end
end
