require 'json'
require 'tout/utils'

module Tout
  module API
    module Users
      include Tout::Utils
      # implements http://developer.tout.com/api-overview/users-api

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-user
      # returns Tout::User instance
      def retrieve_user(uid)
        response = get("/api/v1/users/#{uid}")
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-touts-liked-user
      # returns Array of Tout::Touts::Tout instances
      def retrieve_user_likes(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/likes", query: {order: order, per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users-touts
      # return Array of Tout::Touts::Tout instances
      def retrieve_user_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-users-follow-user
      # returns Array of Tout:User instances
      def retrieve_user_followers(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/followers", query: {order: order, per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/follow-user
      def follow_user(uid)
        resp = post("/api/v1/users/#{uid}/follows")
        raise "Requires auth, not implemented"
      end

      # implements http://developer.tout.com/api/users-api/apimethod/unfollow-user
      def unfollow_user(uid)
        resp = delete("/api/v1/users/#{uid}/follows")
        raise "Requires auth, not implemented"
      end

    end
  end
end
