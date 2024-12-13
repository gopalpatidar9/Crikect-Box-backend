class Match < ApplicationRecord
  belongs_to :competition
  has_one :teama, class_name: 'Teama'
  has_one :teamb, class_name: 'Teamb'
  has_many :teama_odds, class_name: 'TeamaOdd'
  has_many :teamb_odds, class_name: 'TeambOdd'
  has_many :settle_odds
  has_many :bets
  has_many :carts

end
