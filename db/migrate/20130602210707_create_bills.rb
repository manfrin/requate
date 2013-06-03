class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :cent_value, default: 0
      t.integer :paid_by_id
      t.integer :household_id

      t.timestamps
    end
  end
end
