class PayroleDetail < ApplicationRecord

  belongs_to :role, optional: true
  belongs_to :employee, optional: true
  has_many   :detail_lines, dependent: :delete_all

end
