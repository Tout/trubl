require_relative '../channel'
require_relative '../users'
require_relative '../touts'

module Trubl
  module API
    module Channel

      # implements http://developer.tout.com/api/channel-api/apimethod/retrieve-channel
      # returns Trubl::Channel instance or nil
      def retrieve_channel(uid)
        response = get("/api/v1/channels/#{uid}")
        Trubl::Channel.new(JSON.parse(response.body)["channel"])
      end

      # implements http://developer.tout.com/api/channel-api/apimethod/retrieve-channel-users
      # returns Array of Trubl::User instances or nil
      def retrieve_channel_users(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/channels/#{uid}/users", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/channel-api/apimethod/retrieve-channel-touts
      # returns Array of Trubl::Tout instances or nil
      def retrieve_channel_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/channels/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

    end
  end
end