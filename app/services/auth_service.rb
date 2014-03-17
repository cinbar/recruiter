require 'oauth2'
require 'net/http'
require 'uri'
class AuthService
  module LinkedIn
    STATE = SecureRandom.hex(15)

    def self.client
      OAuth2::Client.new(
        Recruiter.settings.linkedin_api_key,
        nil,
        :authorize_url => "/uas/oauth2/authorization?response_type=code",
        :token_url => "/uas/oauth2/accessToken",
        :site => "https://www.linkedin.com"
       )
    end

    def self.authorize
      client.auth_code.authorize_url(:scope => 'r_fullprofile r_emailaddress r_network', 
                                               :state => STATE, 
                                               :redirect_uri => Recruiter.settings.linkedin_redirect_url)
    end

    def self.identify token
      Rails.logger.debug("Identifying")
      uri = URI.parse('https://api.linkedin.com/v1/people/~:(id)')
      uri.query = URI.encode_www_form({oauth2_access_token: token})
      res = Net::HTTP.get_response(uri)
      case res
        when Net::HTTPUnauthorized
           Rails.logger.debug("fuck, unauthorized")
          # Handle 401 Unauthorized response
        when Net::HTTPForbidden
           Rails.logger.debug("fuck, forbidden")
          # Handle 403 Forbidden response          
      end
      parsed_response  = Nokogiri::XML(res.body)

      Rails.logger.debug("#{parsed_response}")
      li_uid = parsed_response.xpath("//person//id").try(:text)
    end
  end
end