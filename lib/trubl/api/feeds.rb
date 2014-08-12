require_relative '../touts'
require_relative '../feed'

module Trubl
  module API
    module Feeds

      #def create_feed(logic = {})
        #response = post("feeds/", body: logic)
        #Trubl::Feed.new.from_response(response)
      #end

      def retrieve_feed(uid)
        response = get("feeds/#{uid}/")
        Trubl::Feed.new.from_response(response)
      end

      def retrieve_feed_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("feeds/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      def retrieve_feed_touts_json(uid, order=nil, per_page=nil, page=nil)
        response = get("feeds/#{uid}/touts.json", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

    end
  end

end
