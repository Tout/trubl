require_relative '../hashtags'
require_relative '../touts'

module Trubl
  module API
    module Hashtags

      # returns Trubl::Hashtag instance or nil
      def retrieve_hashtag(uid)
        response = get("hashtags/#{uid}")
        Trubl::Hashtag.new.from_response(response)
      end

      # implements http://developer.tout.com/api/hashtags-api/apimethod/retrieve-hashtags-touts
      # returns Array of Trubl::Hastag instances or nil
      def retrieve_hashtag_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("hashtags/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation
      # returns Array of Trubl::Hastag instances or nil
      def retrieve_suggested_hashtags(q, limit=nil)
        response = get("suggested_hashtags", query: {q: q, limit: limit})
        Trubl::Hashtags.new.from_response(response)
      end
    end
  end
end
