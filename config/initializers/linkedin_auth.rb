class LinkedinStrategy < ::Warden::Strategies::Base
  def valid? 
    return false if request.get?
    token = params.fetch("access_token",{})
    !(token.blank?)
  end 

  def authenticate! 
    li_uid = AuthService::LinkedIn.identify params.fetch("access_token")
    fail!("Could not get uid via linkedin") and return if li_uid.blank?
    user = User.find_by_linkedin_user_id(li_uid)
    if user.nil? 
      fail!("Authentication Failure") 
    else
      success! user
    end
  end 
end 


Warden::Strategies.add(:linkedin, LinkedinStrategy)
