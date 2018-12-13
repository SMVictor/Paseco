class Role < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines
  accepts_nested_attributes_for :role_lines, reject_if: :all_blank, allow_destroy: true
end
