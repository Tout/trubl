require_relative '../users'

module Trubl
  module API
    module Leaderboard

      # returns a Trubl::Users instance
      def retrieve_leaderboard_users(per_page=nil)
        response = get("/api/v1/leaderboard/users", query: {per_page: per_page})
        Trubl::Users.new.from_response(response)
      end

      # returns a Trubl::Users instance
      def retrieve_leaderboard_users_before(before_uid, per_page=nil)
        response = get("/api/v1/leaderboard/users", query: {before_uid: before_uid, per_page: per_page})
        Trubl::Users.new.from_response(response)
      end

      # returns a Trubl::Users instance
      def retrieve_leaderboard_users_after(after_uid, per_page=nil)
        response = get("/api/v1/leaderboard/users", query: {after_uid: after_uid, per_page: per_page})
        Trubl::Users.new.from_response(response)
      end

    end
  end
end