class AddQuoteToStalls < ActiveRecord::Migration[5.2]
  def change
    add_reference :stalls, :quote, foreign_key: true
  end
end
