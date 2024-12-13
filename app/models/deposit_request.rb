class DepositRequest < ApplicationRecord
  belongs_to :user
  belongs_to :deposit_request_status, class_name: 'DepositRequestStatus'
end
