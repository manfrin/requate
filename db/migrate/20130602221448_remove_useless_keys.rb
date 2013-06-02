class RemoveUselessKeys < ActiveRecord::Migration
  def change
  	remove_column :households, :household_bill_id
  	remove_column :households, :household_member_id
  	remove_column :households, :household_regular_bill_id
  	remove_column :households, :address_entry_id

  	remove_column :bills, :household_id
  	remove_column :bills, :paid_by_id

  end
end
