module Trubl
  module V2
    class Stories < Trubl::V2::Base

      def list(opts={})
        client.retrieve_stories(order(opts) || "highest_positition_first", per_page(opts), page(opts))
      end

      def find(uid, opts={})
        client.retrieve_story(uid)
      end

      def touts(uid, opts={})
        client.retrieve_story_touts(uid, order(opts) || "most_recent_first", per_page(opts), page(opts))
      end

    end
  end
end