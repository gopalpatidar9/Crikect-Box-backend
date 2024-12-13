class LiveOddsType < ApplicationRecord 
  has_many :bets
  has_many :carts
end
