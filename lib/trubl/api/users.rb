require_relative '../touts'
require_relative '../user'
require_relative '../users'
require 'json'

module Trubl
  module API
    module Users
      # implements http://developer.tout.com/api-overview/users-api

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-user
      # returns Trubl::User instance
      def retrieve_user(uid)
        response = get("/api/v1/users/#{uid}")
        Trubl::User.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-touts-liked-user
      # returns Array of Trubl::Tout instances
      def retrieve_user_likes(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/likes", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users-touts
      # return Array of Trubl::Tout instances
      def retrieve_user_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-users-follow-user
      # returns Array of Tout:User instances
      def retrieve_user_followers(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/followers", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/follow-user
      def follow_user(uid)
        post("/api/v1/users/#{uid}/follows")
      end

      # implements http://developer.tout.com/api/users-api/apimethod/unfollow-user
      def unfollow_user(uid)
        delete("/api/v1/users/#{uid}/follows")
      end

    end
  end
end
