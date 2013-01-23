require_relative './retout/client'

module ReTout
  class << self

    # @param [String] client_id
    # @param [String] client_secret
    # @param [String] access_token

    # @return [ReTout::Client]
    def client(client_id='', client_secret='', callback_url='', access_token=nil)
      @client = ReTout::Client.new(client_id, client_secret, callback_url, access_token) unless defined?(@client) && @client.access_token == access_token && @client.access_token != nil
      @client
    end

  end
end
