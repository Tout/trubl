require 'trubl/base'

module Trubl
  class User < Trubl::Base

    def likes
      Trubl.client.retrieve_user_likes(self.uid)
    end

    def touts
      Trubl.client.retrieve_user_touts(self.uid)
    end

    def followers
      Trubl.client.retrieve_user_followers(self.uid)
    end

# the below methods require_relative acting on the behalf of users, which is not yet implemented
=begin
      def follow
        Trubl.client.follow_user(self.uid)
      end

      def unfollow
        Trubl.client.unfollow_user(self.uid)
      end
=end
  end
end
