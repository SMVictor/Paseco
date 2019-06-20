class Requirement < ApplicationRecord
 belongs_to :stall
 belongs_to :shift
 belongs_to :position
end
