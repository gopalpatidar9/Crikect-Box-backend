class Api::V1::BetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bet, only: [:show]
  
  def index
    @bets = current_user.bets
    if @bets
      render json: @bets, status: :ok 
    else
      render json: {error: 'Bets not found'}, status: :not_found
    end
  end
   
  def show_pending_bets
    pending_bets = current_user.bets.joins(:bet_status).where(bet_statuses: { name: 'Pending' })
    if pending_bets.any?
      render json: pending_bets, status: :ok
    else
      render json: {error: "Pending bets not found"}, status: :not_found
    end
  end

  def show_completed_bets
    completed_bets = current_user.bets.joins(:bet_status).where(bet_statuses: { name: 'Completed' })
    if completed_bets.any?
      render json: completed_bets, status: :ok
    else
      render json: {error: "Completed bets not found"}, status: :not_found
    end
  end

  def show_cancle_bets
    cancle_bets = current_user.bets.joins(:bet_status).where(bet_statuses: { name: 'Cancle' })
    if cancle_bets.any?
      render json: cancle_bets, status: :ok
    else
      render json: {error: "Completed bets not found"}, status: :not_found
    end
  end
  
  private

  def set_bet
    @bet = current_user.bets.find(params[:id])
  end

  def bet_params
    params.require(:bet).permit
    (
      :team_number, :odd_type, :odd_value,
      :team_name, :team_id, :mid, :amount,
      :match_title, :bet_status, :live_odds_type,
      :match_id, :completed_at
    )
  end
end
