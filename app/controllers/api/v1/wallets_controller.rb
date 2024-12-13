class Api::V1::WalletsController < ApplicationController
  before_action :authenticate_user!

  def index
    wallet = current_user.wallet
    render json: wallet, status: :ok
  end
end
