class SubService < ApplicationRecord
  belongs_to :service
  has_many :role_lines
  has_and_belongs_to_many :employees, join_table: :employees_sub_services
end
