class UserMailer < ApplicationMailer

  def registration_confirmation(user)
  	@user = user
  	mail to: user.email, subject: 'Bienvenido a PaSeCo A&B'
  end
  
end