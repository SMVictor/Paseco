class Quote < ApplicationRecord
  belongs_to :payment
  has_many :requirements, dependent: :destroy
  accepts_nested_attributes_for :requirements, reject_if: :all_blank, allow_destroy: true
end
