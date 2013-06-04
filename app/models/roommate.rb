class Roommate < ActiveRecord::Base
	belongs_to :user
	belongs_to :household

	def paid_to_household
		0
	end

	def owes_to_household
		(household.total_bills / household.roommates_in_household) - paid_to_household
	end
end