require_relative './exceptions'
require 'hashie'
require 'httparty'

module Trubl
  module OAuth
    # implements OAuth per from http://developer.tout.com/apis/authentication

    # implements client_credentials access_token retrieval
    def client_auth()
      url = URI.join(@auth_site, @token_url).to_s
      body = {
        client_id:     @client_id,
        client_secret: @client_secret,
        grant_type:    "client_credentials"
      }

      request_access_token(url, body, headers)
    end

    # ToDo: add some param checking logic
    def password_auth(opts={})
      url = URI.join(@auth_site, @token_url).to_s
      body = {
        client_id:     @client_id,
        client_secret: @client_secret,
        email:         @email,
        password:      @password,
        scope:         "read write share update_auth",
        grant_type:    "password"
      }.merge(opts)

      request_access_token(url, body, headers)
    end

    alias :user_auth :password_auth

    def request_access_token(url, body, headers)
      Trubl.logger.info("Trubl::OAuth   post-ing #{url} with params #{{body: body, headers: headers}}")
      response = HTTParty.send(:post, url, body: body, headers: headers)
      Trubl.logger.debug("Trubl::OAuth   #{url} response: #{response.code} #{response.body}")

      if response.code != 200
        raise AuthError, JSON.parse(response.body)["error_description"]
      end

      begin
        parsed_response = parse(response)
        @auth_response = Hashie::Mash.new(parsed_response)
        @access_token = @auth_response.access_token
      rescue JSON::ParserError
        raise AuthError, "Client failed to get an access_token, response was: " + response.body
      end

      @access_token

    end

    def parse(response)
      JSON.parse(response.body)
    end

    # ToDo: add autocreate_user, twitter, facebook, etc

  end

end
