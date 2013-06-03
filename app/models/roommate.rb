class Roommate < ActiveRecord::Base
	belongs_to :user
	belongs_to :household
end