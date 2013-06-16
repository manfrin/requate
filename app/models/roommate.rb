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
		total = 0
		Payment.where(to: id).each { |b| total+= b.cent_value}
		Payment.where(from: id).each { |b| total -= b.cent_value}

		total
	end

	def owed_from_household
		total = 0
		Payment.where(to: id).each { |b| total+= b.cent_value}

		total
	end

	def roommate_string
		"#{user.email} - #{household.household_name}"
	end
end