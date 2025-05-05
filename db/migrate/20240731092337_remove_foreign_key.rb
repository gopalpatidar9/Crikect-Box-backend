class RemoveForeignKey < ActiveRecord::Migration[7.0]
  def change
    if foreign_key_exists?(:matches, :match_statuses, column: :matchstatus_id)
      remove_foreign_key :matches, :match_statuses, column: :matchstatus_id
    end

    if foreign_key_exists?(:deposit_requests, :deposit_request_statuses, column: :depositreqeststatus_id)
      remove_foreign_key :deposit_requests, :deposit_request_statuses, column: :depositreqeststatus_id
    end

    if foreign_key_exists?(:withdrawal_requests, :withdrawal_request_statuses, column: :WithdrawalRequestStatus_id)
      remove_foreign_key :withdrawal_requests, :withdrawal_request_statuses, column: :WithdrawalRequestStatus_id
    end
  end
end
