class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def almost_current_user
    @almost_current_user ||= User.find(session[:almost_user_id]) if session[:almost_user_id]
  end
  helper_method :almost_current_user
end
