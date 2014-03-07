Warden::Strategies.add(:backend_auth) do 
  def valid? 
    params[:access_token]
  end 

  def authenticate! 
    li_uid = AuthService::LinkedIn.identify params[:access_token]
    u = User.find_by_linkedin_user_id(li_uid)
    if u
      Rails.logger.debug("found a user for #{li_uid}")
    end
    u.nil? ? fail!("Authentication Failure") : success!(u)
  end 
end 