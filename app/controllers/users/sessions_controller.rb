require 'uri'
require 'net/http'
require 'json'

class Users::SessionsController < ApplicationController
  def new
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
    Rails.logger.debug("validating")
    auth_params = {
      auth_code: params[:code], 
      state: params[:state], 
      redirect_uri: Recruiter.settings.linkedin_redirect_url
    }.to_json
    #  we need to message our backend to see if there is a token in our db for this auth code
    #  this is done via ajax in the view
    uri = URI.parse(Recruiter.settings.validate_token_url)
    @data = {params: auth_params}.to_json.html_safe
    @url  = uri
  end
  
  def identify
    authenticate!
    if current_user
      flash[:info] = "Login Successful"
      head :ok
    else
      head :error
    end
  end
  
  def destroy
    env['warden'].logout
    redirect_to root_url
  end
end