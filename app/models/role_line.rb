class RoleLine < ApplicationRecord
  belongs_to :role
  belongs_to :employee
  belongs_to :stall
  belongs_to :shift
  belongs_to :sub_service
  belongs_to :position       , optional: true
  has_one    :role_lines_copy, dependent: :destroy
  has_one    :detail_line    , dependent: :destroy

  attr_accessor :day
  attr_accessor :date_2
end
