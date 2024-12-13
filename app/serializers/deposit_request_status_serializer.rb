class DepositRequestStatusSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :order, :is_active

  # has_many :deposit_requests #, serializer: DepositRequestSerializer
end
