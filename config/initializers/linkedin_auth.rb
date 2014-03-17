class LinkedinStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?
    token = params.fetch("access_token",{})
    !(token.blank?)
  end 

  def authenticate!
    oauth_token =  params.fetch("access_token")
    begin
      li_uid = AuthService::LinkedIn.identify(oauth_token)
    rescue Exception => ex
      Rails.logger.error("Authentication Failure: #{ex.message}")
    end
    fail!("Could not get uid via linkedin") and return if li_uid.blank?    
    user = User.find_by_linked_in_id(li_uid).try(:id)
    if user.nil? 
      fail!("Authentication Failure") 
    else
      success! user
    end
  end 
end 


Warden::Strategies.add(:linkedin, LinkedinStrategy)
