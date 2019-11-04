class Stall < ApplicationRecord
  belongs_to :customer
  belongs_to :quote
  has_many :role_lines
  has_many :detail_lines
  has_and_belongs_to_many :employees
end
