class AdminMailer < ApplicationMailer

	
  def reply_message_email(message, reply)
    @message = message
    @reply = reply
    mail(to: @message.email, subject: "Donation Platform Reply to: "+@message.subject)
  end

  def invite_email(user, rand_password)
  	@user = user
  	@rand_password = rand_password
  	@url  = 'http://localhost:3000/admin'
  	mail(to: @user.email, subject: "Donation Platform invitation for administration")
  end
end
