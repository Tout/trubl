require_relative '../touts'
require_relative '../playlist'

module Trubl
  module API
    module Playlists

      #def create_playlist(logic = {})
        #response = post("playlists/", body: logic)
        #Trubl::Playlist.new.from_response(response)
      #end

      def retrieve_playlist(uid)
        response = get("playlists/#{uid}/")
        Trubl::Playlist.new.from_response(response)
      end


      def retrieve_playlist_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("playlists/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      def retrieve_playlist_touts_json(uid, order=nil, per_page=nil, page=nil)
        response = get("playlists/#{uid}/touts.json", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

    end
  end

end
