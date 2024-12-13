class RemoveColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :matches, :matchstatus_id
    remove_column :deposit_requests, :depositreqeststatus_id
    remove_column :withdrawal_requests, :WithdrawalRequestStatus_id
  end
end
