class UserMailer < ApplicationMailer

	
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/donor/login'
    mail(to: @user.email, subject: 'Welcome to Our Awesome Site')
  end

  def payment_ignorance_email(need,user, payment)
    @user = user
    @need = need
    @payment = payment
    @organization=@need.organization
    @url  = 'http://localhost:3000/donor/login'
    mail(to: @user.email, subject: ' Your Payment request was rejected' )
  end

end
