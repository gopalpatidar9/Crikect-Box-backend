class MatchStatusSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :order, :is_active

  # has_many :matches #, serializer: MatchSerializer
end
