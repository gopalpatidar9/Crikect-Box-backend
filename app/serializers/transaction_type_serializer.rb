class TransactionTypeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :order, :is_active

  # has_many :transactions  #, serializer: TransactionSerializer
end
