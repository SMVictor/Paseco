class Customer < ApplicationRecord
  has_many :stalls
  has_many :entries
  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true
end
