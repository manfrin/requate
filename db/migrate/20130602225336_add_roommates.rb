class AddRoommates < ActiveRecord::Migration
  def change
  	create_table :roommates do |t|
  		t.integer :household_id
  		t.integer :user_id
  	end
  end
end
