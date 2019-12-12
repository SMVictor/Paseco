class AddBankToChristmasBonifications < ActiveRecord::Migration[5.2]
  def change
    add_column :christmas_bonifications, :bank, :string
    add_column :christmas_bonifications, :account, :string
    add_column :christmas_bonifications, :name, :string
  end
end
