class EmployeeMailer < ApplicationMailer
  def send_payslip(payrole, employee)
  	@payrole  = payrole
  	@employee = employee
  	mail to: @employee.email, subject: 'Boleta de Pago'
  end
end
