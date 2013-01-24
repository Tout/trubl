require_relative '../touts'

module ReTout
  module API
    module Streams

      def retrieve_stream_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("streams/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        ReTout::Touts.new.from_response(response)
      end

    end
  end
end
