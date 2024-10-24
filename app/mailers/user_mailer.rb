class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user 

    @url  = 'https://saveurs-saisonnieres.vercel.app/login' 

    mail(to: @user.email, subject: 'Bienvenue chez Saveurs Saisonnières !') 
  end

  def reset_password_instructions(user)
    @user = user
    @reset_password_url = edit_user_password_url(reset_password_token: @user.reset_password_token)

    puts "reset_password_instructions method called"

    puts render_to_string(template: 'user_mailer/reset_password_instructions')

    mail(to: @user.email, subject: 'Reset your password')
  end
end