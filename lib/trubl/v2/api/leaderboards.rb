module Trubl
  module V2
    class Leaderboards < Trubl::V2::Base
      def users(opts={})
        client.retrieve_leaderboard_users(per_page(opts))
      end

      def users_before(uid, opts={})
        client.retrieve_leaderboard_users_before(uid, per_page(opts))
      end

      def users_after(opts={})
        client.retrieve_leaderboard_users_after(uid, per_page(opts))
      end
    end
  end
end