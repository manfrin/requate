class Bill < ActiveRecord::Base
  attr_accessible :cent_value, :household_id, :roommate_id, :bill_type

  belongs_to :household
  has_one :roomate

  after_create :initial_bill_payments

  def initial_bill_payments
  	roommates    = household.roommates
  	split_amount = cent_value / roommates.count # To be expanded
    roommate     = Roommate.find(roommate_id)

  	roommates.each do |roommate_unpaid|

      next if roommate_unpaid.id == roommate_id

      roommate_split = split_amount

      owes_to = roommate.owes_to_roommate(roommate_unpaid)

      all_params = {
        from: roommate_id, 
        to: roommate_unpaid.id, 
        related_bill_id: self.id
      }

      payment_params = {
        cent_value: roommate_split,      
        initial_bill_split: true ,
        repayment_needed: true
      }

      if owes_to > 0  # In the case bill-payer owes more than $0

        payments = Payment.where(to: roommate_id, from: roommate_unpaid.id, repayment_needed: true)

        payments.each do |payment|
          if payment.cent_value < roommate_split

            split_params = { cent_value: payment.cent_value,
                             initial_bill_split: false,
                             repayment_needed: false }

            Payment.create(split_params.merge!(all_params))

            payment.update_attributes(repayment_needed: false)

            roommate_split -= payment.cent_value
          else
            last_split_params = { cent_value: roommate_split,
                                  initial_bill_split: true,
                                  repayment_needed: true }

            Payment.create(last_split_params.merge!(all_params))
          end
        end

        # Remainder 
        if roommate_split > 0
          last_split_params = { cent_value: roommate_split,
                                initial_bill_split: true,
                                repayment_needed: true }

          Payment.create(last_split_params.merge!(all_params))
        end

      else
  		  Payment.create(payment_params.merge!(all_params)) 
      end
  	end

  end

end	
