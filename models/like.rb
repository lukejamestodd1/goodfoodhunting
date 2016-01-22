class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
	# validates :user, presence: true
	# validates :dish, presence: true
end 