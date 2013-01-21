require 'tout/client'

module Tout
  class << self

    # @param [String] client_id
    # @param [String] client_secret
    # @param [String] access_token

    # @return [Tout::Client]
    def client(client_id='', client_secret='', callback_url='', access_token=nil)
      @client = Tout::Client.new(client_id, client_secret, callback_url, access_token) unless defined?(@client) && @client.access_token == access_token && @client.access_token != nil
      @client
    end

  end
end
