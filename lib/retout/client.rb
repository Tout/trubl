require 'retout/api/conversation'
require 'retout/api/hashtags'
require 'retout/api/me'
require 'retout/api/search'
require 'retout/api/touts'
require 'retout/api/users'
require 'retout/oauth'
require 'retout/utils'

require 'httparty'
require 'json'
require 'uri'
require 'net/http/post/multipart'


# instantiate a Tout client instance
module ReTout
  # Wrapper for the Tout REST API
  #
  # @note All methods have been separated into modules and follow the grouping used in http://developer.tout.com/apis the Tout API Documentation.
  class Client
    include ReTout::API::Conversation
    include ReTout::API::Hashtags
    include ReTout::API::Me
    include ReTout::API::Search
    include ReTout::API::Touts
    include ReTout::API::Users
    include ReTout::OAuth

    attr_reader :client_id, :client_secret, :access_token, :callback_url

    # Initialize a new Tout client with creds and callback url
    def initialize(client_id='', client_secret='', callback_url='', access_token='', uri_scheme = 'https', uri_host='https://api.tout.com/', uri_base_path='api/', uri_version='v1/')
      @client_id = client_id
      @client_secret = client_secret
      @access_token = access_token
      @callback_url = callback_url
      @uri_scheme = uri_scheme
      @uri_host = uri_host
      @uri_base_path = uri_base_path
      @uri_version = uri_version
    end

    def credentials()
      {client_id: @client_id,
      client_secret: @client_secret,
      access_token: @access_token}
    end

    def api_uri_root()
      URI::join(@uri_scheme, @uri_host, @uri_base_path, @uri_version).to_s
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

    # Perform an HTTP Multipart Form Request
    def multipart_post(path, file, params={})
      raise ArgumentError.new('Must specify a valid file to include') unless File.exists(file)
      File.open(file) do |f|
        req = Net::HTTP::Post::Multipart.new full_uri(path), options(params).merge("file" => UploadIO.new(f, 'audio/mp4', 'audio.mp4'))
        response = Net::HTTP.start(url.host, url.port) do |http|
          http.request(req)
        end
      end
      response
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

    # ToDo: model response handling off of oauth2.client.request
    # in fact, perhaps we swap this out for the oauth2 request method...
    def request(method, path, params={})
      response = HTTParty.send(method, full_uri(path), options(params))
      if response.code != 200
        puts "Non 200 status code #{method}-ing '#{uri}'. Was: #{response.code}. Reason: #{response.parsed_response}"
      end
      response
    end

    private
    # Fully qualified uri
    def full_uri(path)
      ReTout::Utils.uri_builder(api_uri_root(), path)
    end

    def headers
      {"Authorization" => "Bearer #{@access_token}"}
    end

    def options(params)
      {headers: headers}.merge(params)
    end

  end
end
