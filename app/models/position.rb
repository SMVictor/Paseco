class Position < ApplicationRecord
  has_many :role_lines
  has_many :requeriments
  has_and_belongs_to_many :employees, join_table: :employees_positions
  belongs_to :area
end
