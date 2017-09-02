class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password, :avatar) }
  end

=begin
sugerencia tirada en el log
  DEPRECATION WARNING: [Devise] Changing the sanitized parameters through "Devise::ParameterSanitizer#for(account_update) is deprecated and it will be removed from Devise 4.2.
Please use the `permit` method:

  devise_parameter_sanitizer.permit(:account_update) do |user|
    # Your block here.
  end
=end

end
