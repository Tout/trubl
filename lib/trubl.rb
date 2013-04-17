require 'yajl'
require 'yajl/json_gem'

require 'logger'
require 'trubl/client'

module Trubl
  class << self

    # Returns a Trubl::Client instance
    #
    # @param [String] client_id
    # @param [String] client_secret
    # @param [String] access_token
    # @return [Trubl::Client]
    def client(client_id='', client_secret='', callback_url='', access_token=nil)
      @client = Trubl::Client.new(client_id, client_secret, callback_url, access_token) unless defined?(@client) && @client.access_token == access_token && @client.access_token != nil
      @client
    end

    def logger(level=Logger::INFO)
      @logger = Logger.new(STDOUT) unless defined?(@logger) and @logger.level != level
      @logger.level = level
      @logger
    end

  end
end
