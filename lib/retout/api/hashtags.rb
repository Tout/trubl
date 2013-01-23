require 'retout/hashtags'
require 'retout/touts'

module ReTout
  module API
    module Hashtags

      # implements http://developer.tout.com/api/hashtags-api/apimethod/retrieve-hashtags-touts
      def retrieve_hashtag_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("hashtags/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        ReTout::Touts.new.from_response(response)
      end

      # http://developer.tout.com/api/hashtags-api/apimethod/retrieve-list-trending-hashtags
      def retrieve_trending_hashtags(per_page=nil, page=nil)
        response = get("trending_hashtags", query: {per_page: per_page, page: page})
        ReTout::Hashtags.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation
      def retrieve_suggested_hashtags(q, limit=nil)
        response = get("suggested_hashtags", query: {q: q, limit: limit})
        ReTout::Hashtags.new.from_response(response)
      end

    end
  end
end
