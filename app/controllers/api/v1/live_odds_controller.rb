class Api::V1::LiveOddsController < ApplicationController
  # before_action :authenticate_user!

  def team_a_odds
    odds = TeamaOdd.all 
    render json: odds, status: :ok
  end

  def team_b_odds
    odds = TeambOdd.all 
    render json: odds, status: :ok
  end

  
end
