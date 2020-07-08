class Disability < ApplicationRecord
  belongs_to :employee, optional: true
end
