class Shift < ApplicationRecord
 belongs_to :payment
 has_many :requeriments
end
