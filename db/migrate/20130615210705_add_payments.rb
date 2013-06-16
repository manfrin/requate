class AddPayments < ActiveRecord::Migration
  def change
  	create_table :payments do |t|
  		t.integer :from
  		t.integer :to
  		t.integer :cent_value
  	end
  end
end
