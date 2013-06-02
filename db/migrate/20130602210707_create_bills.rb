class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.int :cent_value

      t.timestamps
    end
  end
end
