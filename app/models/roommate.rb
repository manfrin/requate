class Roommate < ActiveRecord::Base
	belongs_to :users
	belongs_to :households
end