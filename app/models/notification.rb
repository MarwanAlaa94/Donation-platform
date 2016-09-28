class Notification < ApplicationRecord
    belongs_to :user
    validates :organization_id, presence: true
    #validates :notification_type, presence: true
end
