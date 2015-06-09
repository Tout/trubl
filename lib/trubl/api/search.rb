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
      def search_touts(query, per_page=nil, page=nil, filter_options={})
        response = search('touts', query, per_page, page, filter_options)
        Trubl::Touts.new.from_response(response)
      end

      def search_touts_json(query, per_page=nil, page=nil, filter_options={})
        response = search('touts.json', query, per_page, page, filter_options)
        Trubl::Touts.new.from_response(response)
      end

      private

      def search(type, query, per_page=nil, page=nil, filter_options={})
        query_params = {
          q: query,
          per_page: per_page,
          page: page
        }.merge(filter_options.slice(*filter_options_whitelist))
        get("search/#{type}", query: query_params)
      end

      def filter_options_whitelist
        %w{organization_uids organization_uid state public}
      end

    end
  end
end
