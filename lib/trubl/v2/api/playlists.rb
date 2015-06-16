module Trubl
  module V2
    class Playlists < Trubl::V2::Base
      def find(uid, opts={})
        client.retrieve_playlist(uid)
      end

      def touts(uid, opts={})
        client.retrieve_playlist_touts(uid, order(opts), per_page(opts), page(opts))
      end

      def touts_json(uid, opts={})
        client.retrieve_playlist_touts_json(uid, order(opts), per_page(opts), page(opts))
      end
    end
  end
end