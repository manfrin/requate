class Household < ActiveRecord::Base
  attr_accessible :household_name, :roommates, :bills, :users

  has_many :bills
  has_many :roommates
  has_many :users, through: :roommates
end
