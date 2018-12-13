class Employee < ApplicationRecord
  has_and_belongs_to_many :stalls
  has_many :role_lines

  enum position: [:"Administrador", :"Conserje", :"Mantenimiento", :"Oficial_1", :"Oficial_2", :"Oficial_3", :"Supervisor_1", :"Supervisor_2"]
end
