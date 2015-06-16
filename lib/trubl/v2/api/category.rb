module Trubl
  module V2
    class Category < Trubl::V2::Base

      def list()
        client.retrieve_categories
      end

      def popular_users(opts={})
        client.retrieve_categories_popular_users(order(opts), per_page(opts), page(opts))
      end

      def popular_channels(opts={})
        client.retrieve_categories_popular_channels(order(opts), per_page(opts), page(opts))
      end

      def find(uid, opts={})
        client.retrieve_category(uid)
      end

      def users(uid, opts={})
        client.retrieve_category_users(uid, order(opts), per_page(opts), page(opts))
      end

      def touts(uid, opts={})
        client.retrieve_category_touts(uid, order(opts), per_page(opts), page(opts))
      end
    end
  end
end