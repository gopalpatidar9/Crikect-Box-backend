class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :wallet_id, :transaction_type_id, :amount,
  :description, :bet_id

  # belongs_to :user, serializer: UserSerializer
  # belongs_to :wallet, serializer: WalletSerializer
  # belongs_to :transaction_type, serializer: TransactionTypeSerializer
end
