class LinkedinStrategy < ::Warden::Strategies::Base
  def valid? 
    return false if request.get?
    token = params.fetch("access_token",{})
    !(token.blank?)
  end 

  def authenticate! 
    Rails.logger.debug("Authenticating")
    li_uid = AuthService::LinkedIn.identify params.fetch("access_token")
    fail!("Could not get uid via linkedin") unless li_uid.present?
    user = User.find_by_linkedin_user_id(li_uid)
    if user.nil? 
      fail!("Authentication Failure") 
    else
    Rails.logger.debug("success!")
      success! user
    end
  end 
end 


Warden::Strategies.add(:linkedin, LinkedinStrategy)
