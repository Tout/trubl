module Trubl
  module V2
    class Search < Trubl::V2::Base
      def hashtags(query, opts={})
        client.search_hashtags(query, per_page(opts), page(opts))
      end
      end

      def users(query, opts={})
        client.search_users(query, per_page(opts), page(opts))
      end

      def touts(query, opts={})
        client.search_touts(query, per_page(opts), page(opts), opts)
      end

      def touts_json(query, opts={})
        client.search_touts_json(query, per_page(opts), page(opts), opts)
      end
    end
  end
end