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

	def paid_back_to_household
		total = 0
		Payment.where(from: id, repayment_needed: false, initial_bill_split: false).each { |b| total+= b.cent_value}

		total
	end

	def owes_to_household
		total = 0
		Payment.where(to: self.id, repayment_needed: true).each { |b| total+= b.cent_value}
		Payment.where(from: self.id, repayment_needed: true).each { |b| total -= b.cent_value}

		total
	end

	def owed_from_household
		total = 0
		Payment.where(from: id, repayment_needed: true).each { |b| total+= b.cent_value}
		Payment.where(to: id, repayment_needed: true).each { |b| total -= b.cent_value}
		total
	end

	def roommate_string
		name = household.try(:household_name) || 'Guest'
		"#{user.email} - #{name}"
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

	def open_owed_from_count
		Payment.where(from: id, repayment_needed: true).count
	end

	def owes_to_roommate_count roommate
		Payment.where(from: roommate.id, to: id, repayment_needed: true).count
	end

	def can_collapse
		(open_owed_from_count > 0) # TODO
	end
end