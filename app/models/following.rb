class Following < ApplicationRecord
    belongs_to :user
    belongs_to :organization

    validates :organization_id, presence: true
    validates :user_id, presence: true
end
