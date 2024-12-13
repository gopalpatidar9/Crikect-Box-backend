class CreateWithdrawalRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :withdrawal_requests do |t|
      t.string :name
      t.integer :order
      t.boolean :is_active
      t.references :WithdrawalRequestStatus, null: false, foreign_key: true
      t.datetime :Request_datetime
      t.datetime :response_datetime

      t.timestamps
    end
  end
end
