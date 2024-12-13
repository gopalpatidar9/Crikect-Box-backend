class Api::V1::UserRolesController < ApplicationController
  before_action :authenticate_user!
  
  def current_user_role
    if current_user
      @user_role = current_user.user_role
      if @user_role
        role_name = @user_role.role.name
        render json: { role_name: role_name }, status: :ok
      else
        render json: { error: 'User roles not found' }, status: :not_found
      end
    else
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
  end
end
