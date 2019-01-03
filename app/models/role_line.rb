class RoleLine < ApplicationRecord
  belongs_to :role
  belongs_to :employee
  belongs_to :stall
  belongs_to :shift
end
