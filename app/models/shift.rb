class Shift < ApplicationRecord
 belongs_to :payment
 has_many :requeriments
 has_many :role_lines
 has_many :detail_lines
end
