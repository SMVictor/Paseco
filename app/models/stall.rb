class Stall < ApplicationRecord
  belongs_to :customer
  belongs_to :payment
  has_many :requirements
  has_many :role_lines
  has_and_belongs_to_many :employees
  accepts_nested_attributes_for :requirements, reject_if: :all_blank, allow_destroy: true
end
