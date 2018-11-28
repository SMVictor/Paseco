class Stall < ApplicationRecord
  belongs_to :customer
  belongs_to :payment
  has_many :requirements
  accepts_nested_attributes_for :requirements, reject_if: :all_blank, allow_destroy: true
end
