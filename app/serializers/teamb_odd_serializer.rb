class TeambOddSerializer < ActiveModel::Serializer
  attributes :id, :live_odds_type, :back, :lay, :back_volume,
             :lay_volume, :match_id, :mid

  # belongs_to :match, serializer: MatchSerializer
end

