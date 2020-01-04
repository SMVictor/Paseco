class SubService < ApplicationRecord
  belongs_to :service
  has_many :employees
end
