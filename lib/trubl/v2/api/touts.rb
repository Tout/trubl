module Trubl
  module V2
    class Touts < Trubl::V2::Base
      def featured(opts={})
        client.featured_touts(opts)
      end

      def liked_by(uid, opts={})
        client.tout_liked_by(uid, order(opts), per_page(opts), page(opts))
      end

      def find(uid, opts={})
        client.retrieve_tout(uid)
      end

      def where_uid(uids=[], opts={})
        client.retrieve_touts(uids)
      end

      def filter(opts={})
        client.filter_touts(opts)
      end

      def replies(uid, opts={})
        client.retrieve_tout_replies(uid)
      end

      def conversation(uid, opts={})
        client.retrieve_tout_conversation(uid)
      end

      def latest(opts={})
        client.latest_touts(per_page(opts), page(opts))
      end

      def updates(opts={})
        client.retrieve_updates(order(opts), per_page(opts), page(opts))
      end

      def create(opts={})
        client.create_tout(opts)
      end

      def update(uid, opts={})
        client.update_tout(uid, opts)
      end

      def delete(uid, opts={})
        client.delete(uid)
      end

      def like(uid, opts={})
        client.like_tout(uid)
      end

      def unlike(uid, opts={})
        client.unlike_tout(uid)
      end

      def retout(uid, opts={})
        client.retout_tout(uid)
      end

      def reply(uid, opts={})
        client.reply_tout(uid, opts)
      end

      def publish(uid, opts={})
        client.publish_tout(uid, opts)
      end

      def reject(uid, opt={})
        client.reject_tout(uid, opts)
      end

      def remove_tout_as_reply(uid, opts={})
        client.remove_tout_as_reply(uid)
      end
    end
  end
end