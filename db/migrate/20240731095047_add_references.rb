class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :matches, :match_status, null: false, foreign_key: true unless column_exists?(:matches, :match_status_id)
    add_reference :deposit_requests, :deposit_request_status, null: false, foreign_key: true unless column_exists?(:deposit_requests, :deposit_request_status_id)
    add_reference :withdrawal_requests, :withdrawal_request_status, null: false, foreign_key: true unless column_exists?(:withdrawal_requests, :withdrawal_request_status_id)
  end
end
