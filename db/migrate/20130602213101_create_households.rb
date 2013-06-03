class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.integer :household_bill_id
      t.integer :household_member_id
      t.integer :household_regular_bill_id
      t.integer :address_entry_id
      t.string :household_name

      t.timestamps
    end
  end
end
