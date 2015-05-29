require_relative '../hashtags'
require_relative '../touts'
require_relative '../users'

module Trubl
  module API
    module Search
      # implements http://developer.tout.com/api-overview/search-api

      def search_hashtags(query, per_page=nil, page=nil)
        response = search('hashtags', query, per_page, page)
        Trubl::Hashtags.new.from_response(response)
      end

      def search_users(query, per_page=nil, page=nil)
        response = search('users', query, per_page, page)
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/search-api/apimethod/search-touts
      # Additional Options:
      #   :organization_uid => optional, [Array<String>] || <String> of organization_uids
      #   :organization_uids => optional, alias of :organization_uid
      def search_touts(query, per_page=nil, page=nil, additional_options={})
        response = search('touts', query, per_page, page, additional_options)
        Trubl::Touts.new.from_response(response)
      end

      def search_touts_json(query, per_page=nil, page=nil, additional_options={})
        response = search('touts.json', query, per_page, page, additional_options)
        Trubl::Touts.new.from_response(response)
      end

      private

      def search(type, query, per_page=nil, page=nil, query_options={})
        query_params = {
          q: query,
          per_page: per_page,
          page: page
        }.merge(query_options)
        get("search/#{type}", query: query_params)
      end

    end
  end
end
