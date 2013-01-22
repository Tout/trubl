require 'retout/utils'

module ReTout
  module API
    module Search
      include ReTout::Utils
      # implements http://developer.tout.com/api-overview/search-api

      def search_hashtags(query, per_page=nil, page=nil)
        ReTout::Utils::Collection.new.from_response(search('hashtags', query, per_page, page))
      end

      def search_users(query, per_page=nil, page=nil)
        response = search('users', query, per_page, page)
        ReTout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/search-api/apimethod/search-touts
      def search_touts(query, per_page=nil, page=nil)
        response = search('touts', query, per_page, page)
        ReTout::Utils::Collection.new.from_response(response)
      end

      private

      def search(type, query, per_page=nil, page=nil)
        response = get("search/#{type}", query: {q: query, per_page: per_page, page: page})
        response
      end

    end
  end
end