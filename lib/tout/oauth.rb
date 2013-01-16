require 'httparty'

module Tout
  module OAuth
    # implements OAuth per from http://developer.tout.com/apis/authentication

    # implements client_credentials access_token retrieval
    def auth(auth_url='https://www.tout.com/oauth/token')
      response = HTTParty.post(auth_url, {body: {client_id: client_id,
                                                   client_secret: client_secret,
                                                   grant_type: 'client_credentials'}})

      json = JSON.parse(response.body)

      if response.code == 200 and json["access_token"] != nil
        @access_token = json["access_token"]
        @headers = {"Authorization" => "Bearer #{json["access_token"]}"}
      else
        raise 'Client failed to get an auth token, response was: ' + json.to_s
      end
    end

  end
end