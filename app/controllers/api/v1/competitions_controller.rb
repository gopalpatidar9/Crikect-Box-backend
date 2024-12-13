class Api::V1::CompetitionsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @competitions = Competition.all 
    render json: @competitions , status: :ok
  end

  def show
    @competition = Competition.find_by(id: params[:id])
    render json: @competition , status: :ok
  end
 
end
