class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :switch_to_public_schema

  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  include ActionController::Serialization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :mobilephone, :external_id, :last_login, :is_active ])
  end

  def switch_to_public_schema
    ActiveRecord::Base.connection.schema_search_path = 'public'
  end
end
