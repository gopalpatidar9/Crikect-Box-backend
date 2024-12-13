class DepositRequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :amount, :user_id, :parent_user_id, :message, :last_updated

  # belongs_to :user, serializer: UserSerializer
  # belongs_to :deposit_request_status, class_name: 'DepositRequestStatus', serializer: DepositRequestStatusSerializer

end
