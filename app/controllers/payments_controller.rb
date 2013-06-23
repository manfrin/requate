class PaymentsController < ApplicationController

	def repay
		from = Roommate.find(params[:from])
		to = Roommate.find(params[:to])
		amount = from.owes_to_roommate(to)

		Payment.create(from: from.id, to: to.id, cent_value: amount, repayment_needed: false)
		Payment.where(from: to.id, to: from.id).each {|p| p.update_attributes(repayment_needed: false)}

		redirect_to from.household
	end

end