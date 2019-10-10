class Requirement < ApplicationRecord
 belongs_to :quote
 belongs_to :shift
 belongs_to :position
end
