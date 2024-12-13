class CartSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :team_number, :odd_type, :odd_value, :team_name, :team_id, :mid, :amount, :match_title, :live_odds_type_id, :match_id
  
  # belongs_to :user, serializer: UserSerializer
  # belongs_to :live_odds_type, serializer: LiveOddsTypeSerializer
  # belongs_to :match, serializer: UserSerializer
end
