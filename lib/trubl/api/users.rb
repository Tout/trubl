require_relative '../touts'
require_relative '../user'
require_relative '../users'

module Trubl
  module API
    module Users
      # implements http://developer.tout.com/api-overview/users-api
      # mixed in to a Client instance, the self passed to response objects is that instance

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-user
      # @param uid [String] a user uid
      # @return [Trubl::User] or nil
      def retrieve_user(uid=nil)
        return nil if uid.blank?

        response = get("/api/v1/users/#{uid}")
        Trubl::User.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users
      # @param uids [Array<String>] of user uids
      # @return [Array<Trubl::User>]
      def retrieve_users(uids=[])
        uids = (uids.is_a?(Array) ? uids : [uids]).compact.uniq.sort
        return [] if uids.blank?

        requests = uids.in_groups_of(100, false).collect do |uid_group|
          {path: "users", query: {uids: uid_group.join(',')} }
        end

        multi_request(:get, requests).
          collect { |response| Trubl::Users.new.from_response(response) }.
          flatten.
          compact
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-touts-liked-user
      # returns Array of Trubl::Tout instances or nil
      def retrieve_user_likes(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/likes", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users-touts
      # return Array of Trubl::Tout instances or nil
      def retrieve_user_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-users-follow-user
      # returns Array of Trubl::User instances or nil
      def retrieve_user_followers(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/followers", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/follow-user
      # returns response object
      def follow_user(uid)
        post("/api/v1/users/#{uid}/follows")
      end

      # implements http://developer.tout.com/api/users-api/apimethod/unfollow-user
      # returns response object
      def unfollow_user(uid)
        delete("/api/v1/users/#{uid}/follows")
      end

    end
  end
end
