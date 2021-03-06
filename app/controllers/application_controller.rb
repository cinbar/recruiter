class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :warden, :signed_in?, :current_user

  def signed_in?
    !current_user.nil?
  end

  def current_user
    begin
      warden.user
    rescue Exception => ex
      Rails.logger.error(ex.message )
      Rails.logger.error(ex.backtrace )
    end
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end
