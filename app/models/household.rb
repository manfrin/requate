class Household < ActiveRecord::Base
  attr_accessible :household_name

  has_many :bills
end
