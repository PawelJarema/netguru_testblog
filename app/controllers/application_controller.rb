class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :set_current_post
  helper_method :current_post
  helper :graphics

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  def set_current_post id
    session[:active_post] = id
  end

  def current_post
    session[:active_post]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :nickname
  end
end
