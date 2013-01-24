require 'active_support/core_ext'

require_relative './retout/client'

module ReTout
  class << self

    # @param [String] client_id
    # @param [String] client_secret
    # @param [String] access_token

    # @return [ReTout::Client]
    def client(client_id=nil, client_secret=nil, callback_url=nil, *args)
      opts = (args.last.is_a?(Hash) ? args.last : {}).with_indifferent_access
      @client = ReTout::Client.new(client_id, client_secret, callback_url, opts) unless defined?(@client) && @client.access_token.present? && @client_access_token != opts[:access_token]
      @client
    end

    def reset!
      @client = nil
    end

  end
end
