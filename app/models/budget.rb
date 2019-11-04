class Budget < ApplicationRecord
  has_many :budget_lines, dependent: :delete_all
  belongs_to :stall
  belongs_to :role
end
