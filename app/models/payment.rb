class Payment < ApplicationRecord
  has_many :stalls
  has_many :shifts
  accepts_nested_attributes_for :shifts, reject_if: :all_blank, allow_destroy: true
end
