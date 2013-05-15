require_relative '../user'
require_relative '../authorizations'

module Trubl
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-authenticated-user
      # returns Trubl::User instance or nil
      def get_me
        Trubl::User.new.from_response(get("me"))
      end

      # implements me/authorizations
      def get_my_authorizations
        response = get("me/authorizations")
        Trubl::Authorizations.new.from_response(response)
      end

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-sharing-settings
      def get_my_fb_sharing_settings
        response = get("me/sharing/facebook")
        JSON.parse(response.body)
      end

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-list-touts-authenticated-user
      # returns Array of Trubl::Tout instances or nil
      def get_my_touts(order="most_recent_first", per_page=nil, page=nil)
        response = get("me/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # returns Array of Trubl::Tout instances or nil
      def get_my_liked_touts(order="most_recent_first", per_page=nil, page=nil)
        response = get("me/likes", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # returns Array of Trubl::User instances or nil
      def friends(order=nil, per_page=nil, page=nil)
        response = get("me/friends", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # order, per_page, page arent supported at the moment
      def widgets(order=nil, per_page=nil, page=nil)
        response = get("me/widgets")
        Trubl::Widgets.new.from_response(response)
      end

    end
  end
end
