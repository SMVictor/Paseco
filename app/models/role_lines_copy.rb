class RoleLinesCopy < ApplicationRecord
  belongs_to :role_line, optional: true
end
