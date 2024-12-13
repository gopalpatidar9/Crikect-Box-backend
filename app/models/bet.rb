class Bet < ApplicationRecord
  belongs_to :bet_status
  belongs_to :live_odds_type
  belongs_to :user
  belongs_to :match
  
  validates :team_number, :odd_type, :odd_value, :team_name, :team_id, :mid, :amount, :match_title, :bet_status_id, :potential_payout, :live_odds_type_id, :match_id, presence: true

  before_save :calculate_potential_payout

  def calculate_potential_payout
    self.potential_payout = self.amount * self.odd_value
  end

end
