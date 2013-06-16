class AddRoommateIdToBills < ActiveRecord::Migration
  def change
  	add_column :bills, :roommate_id, :integer
  end
end
