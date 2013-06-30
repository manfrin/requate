class User < ActiveRecord::Base
  attr_accessible :email, :roommates, :bills, :household_ids, :name

  has_many :bills
  has_many :roommates
  has_many :households, through: :roommates

  def total_owed
  	total = 0
  	roommates.each do |r|
  		total += r.owes_to_household
  	end
  	total
  end
end
