class LinkedinStrategy < ::Warden::Strategies::Base
  def valid? 
    #return false if request.get?
    # token = params.fetch("access_token",{})
    # !(token.blank?)
  end 

  def authenticate!
    Rails.logger.debug("Authenticating")
    li_uid = AuthService::LinkedIn.identify params.fetch("access_token")
    Rails.logger.debug("#{li_uid}")
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
