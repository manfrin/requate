class AddInitialBillSplitToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :initial_bill_split, :boolean, default: false
  end
end
