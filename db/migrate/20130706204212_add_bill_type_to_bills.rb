class AddBillTypeToBills < ActiveRecord::Migration
  def change
    add_column :bills, :bill_type, :string
    add_column :payments, :related_bill_id, :integer
  end
end
