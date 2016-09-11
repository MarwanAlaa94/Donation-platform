class AdminMailer < ApplicationMailer

	
  def reply_message_email(message, reply)
    @message = message
    @reply = reply
    mail(to: @message.email, subject: "Donation Platform Reply to: "+@message.subject)
  end

end
