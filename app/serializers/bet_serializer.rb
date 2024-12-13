class BetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :team_number, :odd_type, :odd_value, :team_name, 
  :team_id, :mid, :amount, :match_title, :potential_payout, 
  :user_id, :bet_status_id, :live_odds_type_id, :match_id
  
  # belongs_to :bet_status, serializer: BetStatusSerializer
  # belongs_to :live_odds_type, serializer: LiveOddsTypeSerializer
  # belongs_to :user, serializer: UserSerializer
  # belongs_to :match, serializer: MatchSerializer
end
