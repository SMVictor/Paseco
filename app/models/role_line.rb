class RoleLine < ApplicationRecord
  belongs_to :role
  belongs_to :employee
  belongs_to :stall
  belongs_to :shift
  has_one    :role_lines_copy, dependent: :destroy

   attr_accessor :day
end
