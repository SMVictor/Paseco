class Stall < ApplicationRecord
  belongs_to :customer
  belongs_to :quote
  belongs_to :type, optional: true
  has_many :role_lines
  has_many :detail_lines
  has_and_belongs_to_many :users, join_table: :stalls_users
  has_and_belongs_to_many :employees, join_table: :employees_stalls
end
