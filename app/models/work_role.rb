class WorkRole < ApplicationRecord
  has_many :work_role_lines, dependent: :delete_all
  accepts_nested_attributes_for :work_role_lines, reject_if: :all_blank, allow_destroy: true
end
