class Shift < ApplicationRecord
 belongs_to :payment
 has_many :requeriments
 has_many :role_lines
end
