class LiveOddsTypeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :odds_type

  # has_many :bets #, serializer: BetSerializer
  # has_many :carts #, serializer: CartSerializer
end
