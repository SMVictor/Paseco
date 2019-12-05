class ChristmasBonification < ApplicationRecord
  belongs_to :employee
  has_many :christmas_bonification_lines
  accepts_nested_attributes_for :christmas_bonification_lines, reject_if: :all_blank, allow_destroy: true
end
