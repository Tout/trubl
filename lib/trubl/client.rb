require_relative './api/category'
require_relative './api/channel'
require_relative './api/conversation'
require_relative './api/hashtags'
require_relative './api/me'
require_relative './api/metrics'
require_relative './api/search'
require_relative './api/stories'
require_relative './api/streams'
require_relative './api/suggested_users'
require_relative './api/touts'
require_relative './api/users'
require_relative './widgets'
require_relative './oauth'

require 'httmultiparty'
require 'uri'
require 'faraday'
require 'active_support/core_ext'

if RUBY_ENGINE == 'ruby'
  require 'typhoeus'
  require 'typhoeus/adapters/faraday'
end

# instantiate a Tout client instance
module Trubl
  # Wrapper for the Tout REST API
  #
  # @note All methods have been separated into modules and follow the grouping used in http://developer.tout.com/apis the Tout API Documentation.
  class Client
    include Trubl::API::Category
    include Trubl::API::Channel
    include Trubl::API::Conversation
    include Trubl::API::Hashtags
    include Trubl::API::Me
    include Trubl::API::Metrics
    include Trubl::API::Search
    include Trubl::API::Stories
    include Trubl::API::Streams
    include Trubl::API::Suggested_Users
    include Trubl::API::Touts
    include Trubl::API::Users
    include Trubl::OAuth

    attr_reader :client_id, :client_secret, :access_token, :callback_url, :auth_response

    # Initialize a new Tout client with creds and callback url
    def initialize(client_id=nil, client_secret=nil, callback_url=nil, *args)
      opts = (args.last.is_a?(Hash) ? args.last : {}).with_indifferent_access

      opts.delete_if { |k, v| v.nil? }.reverse_merge!(default_tout_configuration)

      @client_id =     client_id
      @client_secret = client_secret
      @access_token =  opts[:access_token]
      @callback_url =  callback_url
      @uri_scheme =    opts[:uri_scheme]
      @uri_host =      opts[:uri_host]
      @uri_port =      opts[:uri_port]
      @uri_base_path = opts[:uri_base_path]
      @uri_version =   opts[:uri_version]
      @auth_site =     opts[:auth_site]
      @authorize_url = opts[:authorize_url]
      @token_url =     opts[:token_url]
      @email =         opts[:email]
      @password =      opts[:password]
    end

    def default_tout_configuration
      {
        uri_scheme:    'https',
        uri_host:      'api.tout.com',
        uri_base_path: '/api',
        uri_version:   'v1',
        auth_site:     'https://www.tout.com/',
        authorize_url: '/oauth/authorize',
        token_url:     '/oauth/token',
        email:         nil,
        password:      nil
      }.with_indifferent_access
    end

    def credentials()
      { 
        client_id:     @client_id,
        client_secret: @client_secret,
        access_token:  @access_token
      }
    end

    def api_uri_root()
      # Changed this from URI.join because scheme became pointless. It could not
      # override the scheme set in the host and the scheme was required to be set
      # in @uri_host or else URI.join throws an error
      URI.parse('').tap do |uri|
        uri.scheme = @uri_scheme
        uri.host   = @uri_host.gsub(/https?:\/\//, '') # strip the scheme if it is part of the hostname
        uri.path   = [@uri_base_path, @uri_version, nil].join('/')
        uri.port   = @uri_port unless @uri_port.blank?
      end.to_s
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
      payload = { 'tout[data]' => Faraday::UploadIO.new(params[:data], 'video/mp4')}.merge(params)

      Trubl.logger.info("Trubl::Client   multipart post-ing #{uri.to_s} (content omitted)")

      Faraday.new(url: uri.host) do |faraday|
        faraday.headers = options
        faraday.request :multipart
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end.post(uri.to_s, payload).tap do |response|      
        if !response.status =~ /20[0-9]/
          Trubl.logger.fatal("Trubl::Client   multipart post-ing #{uri.to_s} #{response.code} #{response.parsed_response}")
        end
      end
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

    # ToDo: model response handling off of oauth2.client.request
    # in fact, perhaps we swap this out for the oauth2 request method...
    def request(method, path, params)
      params ||= {}
      uri = full_url(path)

      Trubl.logger.info("Trubl::Client   #{method}-ing #{uri} with params #{params.merge(headers: headers)}")
      response = HTTMultiParty.send(method, uri, params.merge(headers: headers))

      if !response.code =~ /20[0-9]/
        Trubl.logger.fatal("Trubl::Client   #{response.code} #{method}-ing #{uri.to_s} #{response.parsed_response}")
      else
        Trubl.logger.debug("Trubl::Client   #{uri} response: #{response.body}")
      end
      response.body.force_encoding("utf-8") if response.body and response.body.respond_to?(:force_encoding)
      response
    end

    def multi_request(method, requests=[], opts={})
      return [] if requests.blank? or [:get].exclude?(method.to_sym)

      if requests.size == 1
        request = requests.first
        path = [request[:path], request[:query].try(:to_query)].compact.join('?')
        return [request(method, path, request[:params])]
      end

      opts.reverse_merge! max_concurrency: 10

      Trubl.logger.info("Trubl::Client   multi-#{method}-ing #{requests.join(', ')} with headers #{headers}")      

      action = RUBY_ENGINE == 'ruby' ? :multi_request_typhoeus : :multi_request_threaded

      self.send(action, method, requests, opts).collect do |response|
        response.body.force_encoding("utf-8") if response.body and response.body.respond_to?(:force_encoding)
        response
      end
    end

    def multi_request_threaded(method, requests=[], opts={})
      responses = []
      mutex = Mutex.new
      requests = requests.clone

      opts[:max_concurrency].times.map do
        Thread.new(requests, responses) do |requests, responses|
          while request = mutex.synchronize { requests.pop }
            response = HTTParty.send(method, full_url(request[:path]), {headers: headers}.merge(request[:params] || {} ))
            mutex.synchronize { responses << response }
          end
        end
      end.each(&:join) 

      responses     
    end

    def multi_request_typhoeus(method, requests=[], opts={})
      # https://github.com/lostisland/faraday/wiki/Parallel-requests
      # https://github.com/typhoeus/typhoeus/issues/226
      hydra = Typhoeus::Hydra.new(max_concurrency: opts[:max_concurrency])
     
      conn = Faraday.new(url: api_uri_root, parallel_manager: hydra) do |builder|
        builder.request  :url_encoded
        builder.adapter  :typhoeus
      end

      requests = requests.collect do |request|
        if request.is_a?(String)
          {path: request, params: {}}
        else
          request.reverse_merge params: {}
        end
      end

      [].tap do |responses|
        conn.in_parallel do
          requests.each do |request|
            path = [request[:path], request[:query].try(:to_query)].compact.join('?')
            responses << conn.send(method, path, request[:params], headers)
          end
        end
      end
    end

    def set_logger(level)
      Trubl.logger(level)
    end

    private
    # Fully qualified uri
    def full_uri(path)
      URI.parse("#{api_uri_root}#{path}")
    end

    # Fully qualified url
    def full_url(path)
      URI.join(api_uri_root, path).to_s
    end

    def headers
      {
        "Authorization" => "Bearer #{@access_token}",
        "Connection"    => 'keep-alive',
        "Accept"        => 'application/json',
        "User-Agent"    => "Trubl/#{Trubl::Version}"
      }
    end

    def options(params={})
      headers.merge(params)
    end

  end
end
