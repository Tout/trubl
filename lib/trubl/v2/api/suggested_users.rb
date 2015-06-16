module Trubl
  module V2
    class SuggestedUsers < Trubl::V2::Base
      def find(query, opts={})
        client.suggested_users(query, per_page(opts), page(opts))
      end
    end
  end
end