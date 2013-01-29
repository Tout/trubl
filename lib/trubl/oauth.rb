require 'httparty'
require 'json'

module Trubl
  module OAuth
    # implements OAuth per from http://developer.tout.com/apis/authentication

    # implements client_credentials access_token retrieval
    def client_auth()
      url = URI.join(@auth_site, @token_url).to_s
      response = HTTParty.send(:post, url, body: {client_id: @client_id,
                                                  client_secret: @client_secret,
                                                  grant_type: "client_credentials"},
                               headers: headers)
      if response.code == 200 and JSON.parse(response.body)["access_token"] != nil
        @access_token = JSON.parse(response.body)["access_token"]
      else
        raise "Client failed to get an auth token, response was: " + response.body
      end
    end

    # ToDo: add some param checking logic
    def user_auth(opts={})
      url = URI.join(@auth_site, @token_url).to_s
      response = HTTParty.send(:post, url, body: {client_id: @client_id,
                                                  client_secret: @client_secret,
                                                  email: @email,
                                                  password: @password,
                                                  scope: "read write share",
                                                  grant_type: "password"}.merge(opts),
                               headers: headers)
      if response.code == 200 and JSON.parse(response.body)["access_token"] != nil
        @access_token = JSON.parse(response.body)["access_token"]
      else
        raise "Client failed to get an auth token, response was: " + response.body
      end
    end

  end
end