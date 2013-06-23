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
		Payment.where(to: id, repayment_needed: true).each { |b| total+= b.cent_value}
		Payment.where(from: id, repayment_needed: true).each { |b| total -= b.cent_value}

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

	def owes_to_roommate roommate
		total = 0
		Payment.where(to: id, from: roommate.id, repayment_needed: true).each { |b| total+= b.cent_value}
		Payment.where(from: id, to: roommate.id, repayment_needed: true).each { |b| total -= b.cent_value}

		total
	end

	def owed_by_roommate roommate
		total = 0
		Payment.where(from: id, to: roommate.id, repayment_needed: true).each { |b| total+= b.cent_value}
		Payment.where(to: id, from: roommate.id, repayment_needed: true).each { |b| total -= b.cent_value}

		total
	end
end