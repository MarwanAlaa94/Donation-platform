class User < ApplicationRecord
  has_and_belongs_to_many :needs

  	has_secure_password
  	validates :user_name, presence: true, uniqueness:{ case_sensetive: false }, length: {in: 3..40}
	validates :password, presence: true, length: {minimmum: 10, maximum:40},confirmation: {case_sensitive: false }

  	VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,presence: true , uniqueness:{ case_sensetive: false }, format: { with: VALID_EMAIL_REGEX}

	def self.from_omniauth(auth)
    	where(auth.slice(:user_name)).first_or_initialize.tap do |user|
      #user.provider = auth.provider
      # user.uid = auth.uid
      user.user_name = auth.info.name
      user.password = "test"

      #user.oauth_token = auth.credentials.token
      #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      
      if auth.info.email == nil
      	user.email = "HtmL5"
      else
      	user.email = auth.info.email
      end
      user.save!
    end
  end

  def send_admin_mail
    UserMailer.welcome_email(self).deliver
  end

end
