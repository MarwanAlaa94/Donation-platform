class Organization < ApplicationRecord
	has_secure_password
		has_many :org_images, :dependent => :destroy
		has_many :needs, :dependent => :destroy
  	#validates_associated :photos
  	#validates_acceptance_of :terms_of_service , :acceptance => true
		accepts_nested_attributes_for :org_images, reject_if: proc { |t| t['caption'].blank? }
		validates :org_name, presence: true, uniqueness:{ case_sensetive: false }, length: {in: 3..40}
		validates :info, presence: true, uniqueness:true, length: {in: 40..700}
        validates :password, presence: true, length: {minimmum: 10, maximum:40},confirmation: {case_sensitive: false }
		validates :website_URL, uniqueness:true, allow_blank: true , length: {in: 10..100 }
		validates :contacts, uniqueness:true, allow_blank: false , length:{in: 12..100 }
		validates :logo_url,uniqueness:true, allow_blank: true , length:{in: 10..100 }
		VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		validates :email,presence: true , uniqueness:{ case_sensetive: false }, format: { with: VALID_EMAIL_REGEX}

		has_attached_file :image, styles: {small:"50x70>" ,medium: "300x300>", thumb: "100x100#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/




    def self.search(search)
    	if search
    		where(["org_name LIKE ?","%#{search}%"])
    	else
    		all
    	end

    end
    def send_admin_approve_mail
        OrganizationMailer.approve_email(self).deliver
    end
    def send_admin_disapprove_mail
        OrganizationMailer.disapprove_email(self).deliver
    end


end
