class AdminController < ApplicationController
  def home
  end

  def sendReply
  	to = params[:email]
	subject="Reply to: " + params[:subject]
    reply = params[:reply]
    Mailer.mail_method(to,subject,reply).deliver
  end
end
