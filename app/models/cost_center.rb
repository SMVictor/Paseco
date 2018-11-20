class CostCenter < ApplicationRecord
  belongs_to :customer
  has_many :stalls
end
