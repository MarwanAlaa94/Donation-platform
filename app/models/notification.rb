class Notification < ApplicationRecord
    belongs_to :user
    validates :organization_id, presence: true
end
