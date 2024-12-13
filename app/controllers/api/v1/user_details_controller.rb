class Api::V1::UserDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_detail, only: [:update, :show]

  
  def index
    @user_detail = current_user.user_detail
    if @user_detail
      render json: @user_detail, status: :ok
    else
      render json: { error: 'User detail not found' }, status: :not_found
    end
  end

  def update
    if @user_detail.update(profilepicture: parmas[:profilepicture])
      render json: @user_detail, status: :updated
    else
      render json: @user_detail.errors, status: :unprocessable_entity
    end
  end

  def show
    if @user_detail
      render json: @user_detail, status: :ok
    else
      render json: { error: 'User detail not found' }, status: :not_found
    end
  end

  private

  def set_user_detail
    @user_detail = current_user.user_detail
  end
end
