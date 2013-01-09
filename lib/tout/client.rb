require 'tout/api/conversation'
require 'tout/api/hashtags'
require 'tout/api/me'
require 'tout/api/search'
require 'tout/api/touts'
require 'tout/api/users'
require 'tout/oauth'

require 'httparty'
require 'json'


# instantiate a Tout client instance
module Tout
  # Wrapper for the Tout REST API
  #
  # @note All methods have been separated into modules and follow the grouping used in http://developer.tout.com/apis the Tout API Documentation.
  class Client
    include Tout::API::Conversation
    include Tout::API::Hashtags
    include Tout::API::Me
    include Tout::API::Search
    include Tout::API::Touts
    include Tout::API::Users
    include Tout::OAuth

    attr_reader :client_id, :client_secret, :access_token, :callback_url

    # Initialize a new Tout client with creds and callback url
    def initialize(client_id='', client_secret='', callback_url='', access_token=nil, base_api_url='https://api.tout.com')
      @client_id = client_id
      @client_secret = client_secret
      @access_token = access_token
      @callback_url = callback_url
      @base_api_url = base_api_url
    end

    def credentials()
      {client_id: @client_id,
      client_secret: @client_secret,
      access_token: @access_token}
    end

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      request(:post, path, params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

    def request(method, path, params={})
      url = "#{@base_api_url}#{path}"
      options = {headers: @headers}.merge(params)
      puts options
      puts url
      HTTParty.send(method, url, options)
    end

  end
end
