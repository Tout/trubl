module Trubl
  module V2
    class Feeds < Trubl::V2::Base
      def find(uid, opts={})
        client.retrieve_feed(uid)
      end

      def touts(uid, opts={})
        client.retrieve_feed_touts(uid, order(opts), per_page(opts), page(opts)))
      end

      def touts_json(uid, opts={})
        client.retrieve_feed_touts_json(uid, order(opts), per_page(opts), page(opts)))
      end
    end
  end
end