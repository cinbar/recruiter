class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :warden, :signed_in?, :current_user

  def signed_in?
    !current_user.nil?
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end
