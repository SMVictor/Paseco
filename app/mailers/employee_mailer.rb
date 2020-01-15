class EmployeeMailer < ApplicationMailer
  def send_payslip(payrole, employee)
  	mail to: 'vic3x94@gmail.com', subject: 'Boleta de Pago'
  end
end
