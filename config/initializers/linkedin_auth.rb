class LinkedinStrategy < ::Warden::Strategies::Base
  def valid? 
    Rails.logger.error("get request, go fuck yourself") if request.get?
    return false if request.get?
    token = params.fetch("access_token",{})
    !(token.blank?)
  end 

  def authenticate!
    oauth_token =  params.fetch("access_token")
    Rails.logger.error("oauth_token: #{oauth_token} ")
    begin
      li_uid = AuthService::LinkedIn.identify oauth_token
      Rails.logger.error("#{li_uid}")
    rescue 
      Rails.logger.error("fuck my life")
    end
    fail!("Could not get uid via linkedin") and return if li_uid.blank?    
    user = User.find_by_linked_in_id(li_uid)
    if user.nil? 
      fail!("Authentication Failure") 
    else
      success! user
    end
  end 
end 


Warden::Strategies.add(:linkedin, LinkedinStrategy)
