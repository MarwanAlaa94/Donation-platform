class Payment < ApplicationRecord
	belongs_to :need
  	belongs_to :user

end
