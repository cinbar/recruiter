require 'uri'
require 'net/http'
require 'json'
class Users::SessionsController < Devise::SessionsController
  
  def new
    super
  end

  def create
    begin
      auth_callback = AuthService::LinkedIn.authorize
      redirect_to auth_callback
    rescue Exception => ex
      Rails.logger.debug("SessionsController: Failed to authorize. #{ex.message}")
    end
  end
  
  def validate
    auth_params = {
      auth_code: params[:code], 
      state: params[:state], 
      redirect_uri: Recruiter.settings.linkedin_redirect_url
    }
    #  we need to message our backend to see if there is a token in our db for this auth code
    #  this is done via ajax in the view
    uri = URI.parse(Recruiter.settings.validate_token_url)
    @data = auth_params.to_json.html_safe
    @url  = uri
  end
  
  def authorize
    response = AuthService::LinkedIn.accept params
  end
  
end