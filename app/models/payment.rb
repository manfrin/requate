class Payment < ActiveRecord::Base
	attr_accessible :from, :to, :cent_value, :repayment_needed
end