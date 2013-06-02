class Household < ActiveRecord::Base
  attr_accessible :address_entry_id, :household_bill_id, :household_member_id, :household_name, :household_regular_bill_id
end
