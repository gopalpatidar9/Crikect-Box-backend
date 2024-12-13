class Api::V1::MatchesController < ApplicationController
  # before_action :authenticate_user!

  def index
    @matches = Match.all
    render json: @matches, each_serializer: MatchSerializer
  end
  
  private

  def set_user
    @user = User.find(params[:id]) if params[:id].present? # Set the user only if :id is provided
  end

end 
