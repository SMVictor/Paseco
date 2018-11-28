class Employee < ApplicationRecord
  belongs_to :stall

  enum role: [:"Administrador", :"Conserje", :"Mantenimiento", :"Oficial_1", :"Oficial_2", :"Oficial_3", :"Supervisor_1", :"Supervisor_2"]
end
