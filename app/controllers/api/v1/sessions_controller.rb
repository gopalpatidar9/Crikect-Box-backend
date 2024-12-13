class Api::V1::SessionsController < ApplicationController
  # Disable CSRF protection for API requests
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def create
    resource = User.find_by(username: params[:username])

    if resource && resource.valid_password?(params[:password])
      token = resource.create_new_auth_token

      response.headers.merge!(
        'access-token' => token['access-token'],
        'client' => token['client'],
        'uid' => token['uid']
      )
      render json: {
        data: resource.as_json.merge(user_role: resource.user_role&.role&.name),
        token: {
          access_token: token['access-token'],
          client: token['client'],
          uid: token['uid']
        }
      }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unprocessable_entity
    end
  end
end
