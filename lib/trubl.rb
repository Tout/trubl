require 'trubl/client'

module Trubl
  class << self

    # @param [String] client_id
    # @param [String] client_secret
    # @param [String] access_token

    # @return [Trubl::Client]
    def client(client_id='', client_secret='', callback_url='', access_token=nil)
      @client = Trubl::Client.new(client_id, client_secret, callback_url, access_token) unless defined?(@client) && @client.access_token == access_token && @client.access_token != nil
      @client
    end

  end
end
