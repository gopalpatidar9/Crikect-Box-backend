class RemoveForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :matches, :match_statuses, column: :matchstatus_id
    remove_foreign_key :deposit_requests, :deposit_request_statuses, column: :depositreqeststatus_id
    remove_foreign_key :withdrawal_requests, :withdrawal_request_statuses, column: :WithdrawalRequestStatus_id
  end
end
