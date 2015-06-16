module Trubl
  module V2
    class Me < Trubl::V2::Base
      def find
        client.get_me
      end

      def find_json
        client.get_me_json
      end

      def update_me(opts={})
        client.update_me(opts)
      end

      def authorizations
        client.get_my_authorizations
      end

      def authorizations_json
        client.get_my_authorizations_json
      end

      def settings
        client.get_my_settings
      end

      def settings_json
        client.get_my_settings_json
      end

      def fb_sharing_settings
        client.get_my_fb_sharing_settings
      end

      def fb_sharing_settings_json
        client.get_my_fb_sharing_settings_json
      end

      def updates(opts={})
        client.get_updates(order(opts) || "most_recent_first", per_page(opts), page(opts))
      end

      def touts(opts={})
        client.get_my_touts(order(opts) || "most_recent_first", per_page(opts), page(opts))
      end

      def liked_touts(opts={})
        client.get_my_liked_touts(order(opts) || "most_recent_first", per_page(opts), page(opts))
      end

      def friends(opts={})
        client.friends(order(opts), per_page(opts), page(opts))
      end

      def widgets(opts={})
        client.widgets(order(opts), per_page(opts), page(opts))
      end

      def notifications
        client.notifications
      end

      def notification_inbox
        client.notification_inbox
      end

      def devices
        client.devices
      end

      def streams
        client.streams
      end

      def channels
        client.channels
      end

      def subscribed_hashtags
        client.subscribed_hashtags
      end

      def digestable_notifications
        client.digestable_notifications
      end

      def blockees
        client.blockees
      end

      def scheduled_touts
        client.get_my_scheduled_touts
      end

      def rejected_touts
        client.get_my_rejected_touts
      end

      def pending_touts
        client.get_my_pending_touts
      end
    end
  end
end