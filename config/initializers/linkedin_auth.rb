class LinkedinStrategy < ::Warden::Strategies::Base
  def valid? 
    return false if request.get?
    token = params.fetch("access_token",{})
    !(token.blank?)
  end 

  def authenticate!
    Rails.logger.debug("Authenticating")
    Rails.logger.error(params.fetch("access_token"))
    begin
      li_uid = AuthService::LinkedIn.identify params.fetch("access_token")
    rescue 
      Rails.logger.error("fuck my life")
    end
    Rails.logger.error("#{li_uid}")
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
