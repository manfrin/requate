class Payment < ActiveRecord::Base
	attr_accessible :from, :to, :cent_value, :repayment_needed, :initial_bill_split
end