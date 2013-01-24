require 'active_support/core_ext'

require_relative './retout/client'

module ReTout
  class << self

    # @param [String] client_id
    # @param [String] client_secret
    # @param [String] access_token

    # @return [ReTout::Client]
    def client(*args)
      opts = (args.last.is_a?(Hash) ? args.last : {}).with_indifferent_access
      @client = ReTout::Client.new(opts) unless defined?(@client) && @client.access_token.present? && @client_access_token ==opts[:access_token]
      @client
    end

  end
end
