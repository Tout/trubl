require 'tout/utils'

module Tout
  module API
    module Hashtags
      include Tout::Utils

      # implements http://developer.tout.com/api/hashtags-api/apimethod/retrieve-hashtags-touts
      def retrieve_hashtag_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/hashtags/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

      # http://developer.tout.com/api/hashtags-api/apimethod/retrieve-list-trending-hashtags
      def retrieve_trending_hashtags(per_page=nil, page=nil)
        response = get("/api/v1/trending_hashtags", query: {per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation
      def retrieve_suggested_hashtags(q, limit=nil)
        response = get("/api/v1/suggested_hashtags", query: {q: q, limit: limit})
        Tout::Utils::Collection.new.from_response(response)
      end

    end
  end
end
