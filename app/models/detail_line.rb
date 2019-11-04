class DetailLine < ApplicationRecord
  belongs_to :payrole_detail
  belongs_to :stall
  belongs_to :shift
end
