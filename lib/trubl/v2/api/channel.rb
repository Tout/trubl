module Trubl
  module V2
    class Channel < Trubl::V2::Base
      def find(uid, opts={})
        client.retrieve_channel(uid)
      end

      def users(uid, opts={})
        client.retrieve_channel_users(uid, order(opts), per_page(opts), page(opts))
      end

      def touts(uid, opts={})
        client.retrieve_channel_touts(uid, order(opts), per_page(opts), page(opts))
      end
    end
  end
end