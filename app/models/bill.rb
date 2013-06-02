class Bill < ActiveRecord::Base
  attr_accessible :cent_value, :household_id

  belongs_to :household
end
