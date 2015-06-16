module Trubl
  module V2
    class Streams < Trubl::V2::Base
      def create(opts={})
        client.create_stream(opts)
      end

      def touts(uid, opts={})
        client.retrieve_stream_touts(uid, order(opts), per_page(opts), page(opts))
      end

      def touts_json(uid, opts={})
        client.retrieve_stream_touts_json(uid, order(opts), per_page(opts), page(opts))
      end
    end
  end
end