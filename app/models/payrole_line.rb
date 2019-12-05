class PayroleLine < ApplicationRecord
  belongs_to :role
  belongs_to :employee, optional: true
end
