module Trubl
  module V2
    class Users < Trubl::V2::Base

      def featured(opts={})
        client.featured_users(per_page(opts), page(opts))
      end

      def find(uid, opts={})
        client.retrieve_user(uid)
      end

      def retrieve_users(uids=[])
        client.retrieve_users(uids)
      end

      def likes(uid, opts={})
        client.retrieve_users(uid, order(opts), per_page(opts), page(opts))
      end

      def touts(uid, opts={})
        client.retrieve_user_touts(uid, order(opts), per_page(opts), page(opts))
      end

      def follower(uid, opts={})
        client.retrieve_user_followers(uid, order(opts), per_page(opts), page(opts))
      end

      def following(uid, opts={})
        client.retrieve_user_user_following(uid, order(opts), per_page(opts), page(opts))
      end

      def widget(uid, opts={})
        client.retrieve_user_widgets(uid, order(opts), per_page(opts), page(opts))
      end

      def follow(uid, opts={})
        client.follow_user(uid)
      end

      def unfollow(uid, opts={})
        client.unfollow_user(uid)
      end

      def update(uid, opts={})
        client.update_user(uid, opts)
      end

      def block_by(uid, blocker_uid, opts={})
        client.block_user_by(uid, blocker_uid)
      end

      def unblock_by(uid, blocker_uid, opts={})
        client.unblock_user_by(uid, blocker_uid)
      end

      # returns true/false
      def update_watermark_from_url(uid, watermark_url, opts={})
        client.update_watermark_from_url(uid, watermark_url)
      end
    end
  end
end