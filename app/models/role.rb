class Role < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines, dependent: :delete_all
  has_many :payrole_lines,  dependent: :delete_all
  has_many :budgets
  accepts_nested_attributes_for :role_lines, reject_if: :all_blank, allow_destroy: true
end