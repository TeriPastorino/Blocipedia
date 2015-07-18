class ApplicationController < ActionController::Base  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end
  

  def current_user
    @current_user ||=User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authenticate
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end


end
