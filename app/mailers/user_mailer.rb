class UserMailer < ApplicationMailer

  def registration_confirmation(user)
  	@user = user
  	mail to: user.email, subject: 'Bienvenido a PaSeCo A&B'
  end

  def send_notification(user, employee)
  	@user = user
  	@employee = employee
  	mail to: user.email, subject: 'Alerta de Cambios'
  end
  
end