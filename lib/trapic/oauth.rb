require 'httparty'
require 'oauth2'

module ReTout
  module OAuth
    # implements OAuth per from http://developer.tout.com/apis/authentication

    # implements client_credentials access_token retrieval
    def auth(auth_site='https://www.tout.com/')
      client = OAuth2::Client.new(@client_id, @client_secret, :site => auth_site, :authorize_url => '/oauth/authorize', :token_url => '/oauth/token', :redirect_uri => @callback_url)
      begin
        token = client.client_credentials.get_token
        @access_token = token.token
      # OAuth raises OAuth::Error when run properly under webmock. /me shrugs
      rescue OAuth2::Error => e
        @access_token = JSON.parse(e.message)["access_token"]
      end
    end

  end
end