class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :matches, :match_status, null: false, foreign_key: true
    add_reference :deposit_requests, :deposit_request_status, null: false, foreign_key: true 
    add_reference :withdrawal_requests, :withdrawal_request_status, null: false, foreign_key: true 
  end
end
