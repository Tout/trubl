require_relative '../hashtags'
require_relative '../touts'
require_relative '../users'

module Trapic
  module API
    module Search
      # implements http://developer.tout.com/api-overview/search-api

      def search_hashtags(query, per_page=nil, page=nil)
        Trapic::Hashtags.new.from_response(search('hashtags', query, per_page, page))
      end

      def search_users(query, per_page=nil, page=nil)
        response = search('users', query, per_page, page)
        Trapic::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/search-api/apimethod/search-touts
      def search_touts(query, per_page=nil, page=nil)
        response = search('touts', query, per_page, page)
        Trapic::Touts.new.from_response(response)
      end

      private

      def search(type, query, per_page=nil, page=nil)
        response = get("search/#{type}", query: {q: query, per_page: per_page, page: page})
        response
      end

    end
  end
end
