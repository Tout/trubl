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
      def search_touts(query, per_page=nil, page=nil)
        response = search('touts', query, per_page, page)
        Trubl::Touts.new.from_response(response)
      end

      # params:
      #   :q => required, <String>, query for fulltext search
      #   :organization_uid => optional, [Array<String>] || <String> of organization_uids
      #   :organization_uids => optional, alias of :organization_uid
      #   :per_page => optional, <integer>, number of touts per page
      #   :page => optional, <integer>, current page of pagination
      # return: [Array<Trubl::Tout>] || nil
      # NOTE: Works like search_touts unless authorized as an internal_application
      def search_touts_by_org(query, organization_uids, per_page=nil, page=nil)
        response = search('touts', query, per_page, page, {organization_uid: organization_uids})
        Trubl::Touts.new.from_response(response)
      end

      def search_touts_json(query, per_page=nil, page=nil)
        response = search('touts.json', query, per_page, page)
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
