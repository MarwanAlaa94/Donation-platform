class User < ApplicationRecord
  has_many :payments
    has_many :needs, through: :payments
    accepts_nested_attributes_for :payments,

             :allow_destroy => true
    accepts_nested_attributes_for :needs

  mount_uploader :avatar, AvatarUploader


  has_secure_password
  validates :user_name, presence: true, uniqueness:{ case_sensetive: false }, length: {in: 3..40}
  validates :password, presence: true, length: {minimmum: 10, maximum:40},confirmation: {case_sensitive: false }

  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true , uniqueness:{ case_sensetive: false }, format: { with: VALID_EMAIL_REGEX}

   # User Avatar Validation
  #validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar



  def self.from_omniauth(auth)
      where(auth.slice(:user_name)).first_or_initialize.tap do |user|
      #user.provider = auth.provider
      # user.uid = auth.uid
      user.user_name = auth.info.name
      user.password = "test"
      user.remote_avatar_url = auth.info.image.gsub('http://','https://')
      #user.oauth_token = auth.credentials.token
      #user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      if auth.info.email == nil
        user.email = "user@example.com"
      else
        user.email = auth.info.email
      end
      user.save!
    end
  end

  def send_admin_mail
    UserMailer.welcome_email(self).deliver
  end
  def send_admin_invitation_mail(rand_password)
    AdminMailer.invite_email(self,rand_password).deliver
  end


  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
