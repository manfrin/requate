class Roommate < ActiveRecord::Base
	belongs_to :user
	belongs_to :household
	has_many :bills
	has_many :payments

	def paid_to_household
		total = 0
		Bill.where(roommate_id: id).each { |b| total+= b.cent_value}

		total
	end

	def owes_to_household
		(household.total_bills / household.roommates_in_household) - paid_to_household
	end

	def roommate_string
		"#{user.email} - #{household.household_name}"
	end
end