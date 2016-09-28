class Need < ApplicationRecord

    has_many :payments
    has_many :users , through: :payments
    accepts_nested_attributes_for :payments,

             :allow_destroy => true
    accepts_nested_attributes_for :users


  belongs_to :organization
  has_many :need_images, :dependent => :destroy

  accepts_nested_attributes_for :need_images, reject_if: proc { |t| t['caption'].blank? }
  validates :organization_id, presence: true
  validates :title, presence: true, length: {in: 5..40}
  validates :description, presence: true, length: {in: 40..700}
  validates :money, presence:true
  validates :urgent_rate, presence:true

  def send_payment_ignorance_mail(user,payment)  
    UserMailer.payment_ignorance_email(self,user, payment).deliver
  end

end
