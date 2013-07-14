class Bill < ActiveRecord::Base
  attr_accessible :cent_value, :household_id, :roommate_id, :bill_type

  belongs_to :household
  has_one :roomate

  after_create :initial_bill_payments
  after_create :equalize_payments

  def initial_bill_payments
  	roommates = household.roommates
  	split_amount = cent_value / roommates.count

  	roommates.each do |r|
  		Payment.create(from: roommate_id, to: r.id, cent_value: split_amount, initial_bill_split: true, related_bill_id: self.id, repayment_needed: true) unless r.id == roommate_id
  	end
  end

  def equalize_payments
    household.roommates.each do |roommate_one|
      household.roommates.each do |roommate_two|
        one_owes_to_two = roommate_one.owes_to_roommate roommate_two
        two_owes_to_one = roommate_two.owes_to_roommate roommate_one

        one_owes_to_two_count = roommate_one.owes_to_roommate_count roommate_two
        two_owes_to_one_count = roommate_two.owes_to_roommate_count roommate_one

        if (one_owes_to_two_count > 0) && (two_owes_to_one_count > 0)
          if one_owes_to_two > two_owes_to_one
            # If one owes two more, make a payment from two to one for 
            # the amount two owes. 
            Payment.create(from: roommate_two, to: roommate_one, cent_value: two_owes_to_one, initial_bill_split: false, related_bill_id: self.id, repayment_needed: false)
            Payment.where(from: roommate_one, to: roommate_two, repayment_needed: true).each { |p| p.update_attributes(repayment_needed: false)}
          else
            Payment.create(from: roommate_one, to: roommate_two, cent_value: one_owes_to_two, initial_bill_split: false, related_bill_id: self.id, repayment_needed: false)
            Payment.where(from: roommate_two, to: roommate_one, repayment_needed: true).each { |p| p.update_attributes(repayment_needed: false)}

          end
        end
      end
    end
  end
end	
