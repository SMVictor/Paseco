class Position < ApplicationRecord
  has_many :role_lines
  has_and_belongs_to_many :employees, join_table: :employees_positions
end
