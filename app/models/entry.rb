class Entry < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :employee, optional: true
  mount_uploader :document, DocumentUploader

end
