class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :config_devise_params, if: :devise_controller?

  def config_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image])
  end
end
