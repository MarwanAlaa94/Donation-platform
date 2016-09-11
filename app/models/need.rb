class Need < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :organization
  has_many :need_images, :dependent => :destroy

  accepts_nested_attributes_for :need_images, reject_if: proc { |t| t['caption'].blank? }
  validates :organization_id, presence: true
  validates :title, presence: true, length: {in: 5..40}
  validates :description, presence: true, length: {in: 40..700}
  validates :start_date, presence:true
  validates :money, presence:true
  validates :urgent_rate, presence:true

end
