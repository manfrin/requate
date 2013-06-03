class User < ActiveRecord::Base
  attr_accessible :email, :roommates, :bills, :household_ids

  has_many :bills
  has_many :roommates
  has_many :households, through: :roommates
end
