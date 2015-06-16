module Trubl
  module V2
    class Hashtags < Trubl::V2::Base
      def find(uid, opts={})
        client.retrieve_hashtag(uid)
      end

      def touts(uid, opts={})
        client.retrieve_hashtag_touts(uid, order(opts), per_page(opts), page(opts)))
      end

      def trending(opts={})
        client.retrieve_trending_hashtags(per_page(opts), page(opts)))
      end

      def suggested(q, opts={})
        client.retrieve_suggested_hashtags(q, opts[:limit])
      end

      def follow(uid, opts={})
        client.follow_hashtag(uid, order(opts), per_page(opts), page(opts)))
      end

      def unfollow_hashtag(uid, opts={})
        client.unfollow_hashtag(uid, order(opts), per_page(opts), page(opts)))
      end
    end
  end
end