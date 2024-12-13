class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :live_odds_type
  belongs_to :match

  validates :team_number, :odd_type, :odd_value, :team_name, :team_id, :mid, :amount, :match_title, :live_odds_type_id, :match_id, presence: true
  
  # def place_bet(bet_status_id, current_user)
  #   bet = Bet.create(
  #     team_number: team_number,
  #     odd_type: odd_type,
  #     odd_value: odd_value,
  #     team_name: team_name,
  #     team_id: team_id,
  #     mid: mid,
  #     amount: amount,
  #     user_id: current_user.id,
  #     match_title: match_title,
  #     bet_status_id: bet_status_id,
  #     live_odds_type_id: live_odds_type_id,
  #     match_id: match_id
  #   )
  #   bet.persisted?
  # end
end
