class AddRepaymentNeededToPaymentTable < ActiveRecord::Migration
  def change
    add_column :payments, :repayment_needed, :boolean, default: true
  end
end
