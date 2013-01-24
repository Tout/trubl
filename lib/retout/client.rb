require_relative './api/conversation'
require_relative './api/hashtags'
require_relative './api/me'
require_relative './api/search'
require_relative './api/streams'
require_relative './api/touts'
require_relative './api/users'
require_relative './oauth'
require_relative './utils'

require 'httparty'
require 'json'
require 'uri'
require 'faraday'
require 'active_support/core_ext'


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
    include ReTout::API::Streams
    include ReTout::API::Touts
    include ReTout::API::Users
    include ReTout::OAuth

    attr_reader :client_id, :client_secret, :access_token, :callback_url

    # Initialize a new Tout client with creds and callback url
    def initialize(*args)
      opts = (args.last.is_a?(Hash) ? args.last : {}).with_indifferent_access
      raise ArgumentError.new(":client_id is required")     unless opts[:client_id].present?
      raise ArgumentError.new(":client_secret is required") unless opts[:client_secret].present?
      raise ArgumentError.new(":callback_url is required")  unless opts[:callback_url].present?

      opts.reverse_merge!(default_tout_configuration)
      @client_id =     opts[:client_id]
      @client_secret = opts[:client_secret]
      @access_token =  opts[:access_token]
      @callback_url =  opts[:callback_url]
      @uri_scheme =    opts[:uri_scheme]
      @uri_host =      opts[:uri_host]
      @uri_base_path = opts[:uri_base_path]
      @uri_version =   opts[:uri_version]
    end

    def default_tout_configuration
      {
        uri_scheme:    'https',
        uri_host:      'api.tout.com',
        uri_base_path: '/api',
        uri_version:   'v1'
      }.with_indifferent_access
    end

    def credentials()
      {client_id: @client_id,
      client_secret: @client_secret,
      access_token: @access_token}
    end

    def api_uri_root()
      # Changed this from URI.join because scheme became pointless. It could not
      # override the scheme set in the host and the scheme was required to be set
      # in @uri_host or else URI.join throws an error
      uri = URI.parse ''
      uri.scheme = @uri_scheme
      uri.host = @uri_host.gsub(/https?:\/\//, '') # strip the scheme if it is part of the hostname
      uri.path = [@uri_base_path, @uri_version].join('/') + '/'
      uri.to_s
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
    def multipart_post(path, params={})
      raise ArgumentError.new("Must specify a valid file to include\nYou specified #{params[:data]}") unless File.exists?(params[:data])
      uri = full_uri(path)
      conn = Faraday.new(url: uri.host) do |faraday|
        faraday.headers = options
        faraday.request :multipart
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
      payload = { 'tout[data]' => Faraday::UploadIO.new(params[:data], 'video/mp4')}.merge(params)
      response = conn.post uri.to_s, payload
      if !response.status =~ /20[0-9]/
        puts "Non 200 status code #{method}-ing '#{uri.to_s}'. Was: #{response.code}. Reason: #{response.parsed_response}"
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
      uri = full_url(path)
      response = HTTParty.send(method, uri, params.merge(headers: headers))
      if response.code != 200
        puts "Non 200 status code #{method}-ing '#{uri}'. Was: #{response.code}. Reason: #{response.parsed_response}"
      end
      response
    end

    private
    # Fully qualified uri
    def full_uri(path)
      URI.parse("#{api_uri_root}#{path}")
    end

    # Fully qualified url
    def full_url(path)
      ReTout::Utils.uri_builder(api_uri_root, path)
    end

    def headers
      {"Authorization" => "Bearer #{@access_token}",
       "Connection" => 'keep-alive',
       "Accept" => 'application/json'}
    end

    def options(params={})
      headers.merge(params)
    end

  end
end
