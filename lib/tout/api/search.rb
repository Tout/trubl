require 'tout/utils'

module Tout
  module API
    module Search
      include Tout::Utils
      # implements http://developer.tout.com/api-overview/search-api

      def search_hashtags(query, per_page=nil, page=nil)
        search('hashtags', query, per_page, page)
      end

      def search_users(query, per_page=nil, page=nil)
        response = search('users', query, per_page, page)
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/search-api/apimethod/search-touts
      def search_touts(query, per_page=nil, page=nil)
        response = search('touts', query, per_page, page)
        Tout::Utils::Collection.new.from_response(response)
      end

      private

      def search(type, query, per_page=nil, page=nil)
        response = get("/api/v1/search/#{type}", query: {q: query, per_page: per_page, page: page})
        response
      end

    end
  end
end
