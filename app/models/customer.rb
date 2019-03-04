class Customer < ApplicationRecord
  has_many :stalls
  mount_uploader :document, DocumentUploader
end
