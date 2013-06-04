class Household < ActiveRecord::Base
  attr_accessible :household_name, :roommates, :bills, :users

  has_many :bills
  has_many :roommates
  has_many :users, through: :roommates

  def total_bills
  	total = 0
    bills.each{|b| total += b.cent_value}
    total
  end

  def roommates_in_household
  	users.count
  end
end
