class WorkRoleLine < ApplicationRecord
  belongs_to :work_role, optional: true
  belongs_to :employee,  optional: true
  belongs_to :stall,     optional: true
  belongs_to :shift,     optional: true
end
