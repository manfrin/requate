class Payment < ActiveRecord::Base
	attr_accessible :from, :to, :cent_value
end