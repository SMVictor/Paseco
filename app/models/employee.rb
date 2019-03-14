class Employee < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines
  has_many :payrole_lines
  has_many :entries
  belongs_to :position

  enum position: [:"Administrador", :"Conserje", :"Mantenimiento", :"Oficial_1", :"Oficial_2", :"Oficial_3", :"Supervisor_1", :"Supervisor_2"]
  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true


  def self.payroll_calculation
  end

end