class Bill < ActiveRecord::Base
  attr_accessible :cent_value, :household_id, :roommate_id, :bill_type

  belongs_to :household
  has_one :roomate

  after_create :initial_bill_payments

  def initial_bill_payments
  	roommates = household.roommates
  	split_amount = cent_value / roommates.count

  	roommates.each do |r|
  		Payment.create(from: roommate_id, to: r.id, cent_value: split_amount, initial_bill_split: true, related_bill_id: self.id) unless r.id == roommate_id
  	end
  end
end	
