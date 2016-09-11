class Message < ApplicationRecord


	def send_admin_reply (reply)
	   AdminMailer.reply_message_email(self, reply).deliver
	 end


end
