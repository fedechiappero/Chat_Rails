class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:email, :password, :password_confirmation, :remember_me)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:password, :password_confirmation, :current_password, :avatar)
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
