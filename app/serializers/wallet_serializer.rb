class WalletSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :balance

  # belongs_to :user, serializer: UserSerializer
  # has_many :transactions #, serializer: TransactionSerializer
end
