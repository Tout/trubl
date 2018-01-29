require_relative '../touts'

module Trubl
  module API
    module Streams

      def create_stream(logic = {})
        response = post("streams/", body: logic)
        Trubl::Stream.new.from_response(response)
      end

      def retrieve_stream_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("streams/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      def retrieve_stream_touts_json(uid, order=nil, per_page=nil, page=nil)
        response = get("streams/#{uid}/touts.json", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end
    end
  end
end
