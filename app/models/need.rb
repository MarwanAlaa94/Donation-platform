class Need < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :organization
  has_many :need_images, :dependent => :destroy

  accepts_nested_attributes_for :need_images, reject_if: proc { |t| t['caption'].blank? }
  validates :organization_id, presence: true
end
