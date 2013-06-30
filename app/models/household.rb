class Household < ActiveRecord::Base
  attr_accessible :household_name, :roommates, :bills, :users

  has_many :bills, dependent: :destroy
  has_many :roommates, dependent: :destroy
  has_many :users, through: :roommates

  def total_bills
  	total = 0
    bills.each{|b| total += b.cent_value}
    total
  end

  def roommates_in_household
  	users.count
  end

  def owes_list
    list = []
    roommates.each do |r|
      roommates.each do |rx|
        owes_to = r.owes_to_roommate(rx)
        if owes_to > 0
          list << {
            owes: owes_to,
            paid_roommate: rx.id,
            to_pay_roommate: r.id,
            display_string: "#{r.user.name} owes #{rx.user.name} $%0.2f" % (owes_to/100.00)
          }
        end
      end
    end

    list
  end
end
