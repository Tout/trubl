require_relative '../touts'
require_relative '../stories'

module Trubl
  module API
    module Stories

      # returns Array of Trubl::Stories instances or nil
      def retrieve_stories(order="highest_position_first", per_page=nil, page=nil)
        response = get("/api/v1/stories/", query: {order: order, per_page: per_page, page: page})
        Trubl::Stories.new.from_response(response)
      end

      # returns a Trubl::Story instances or nil
      def retrieve_story(uid)
        response = get("/api/v1/stories/#{uid}")
        Trubl::Story.new.from_response(response)
      end

      # returns Array of Trubl::Tout instances or nil
      def retrieve_story_touts(uid, order="most_recent_first", per_page=nil, page=nil)
        response = get("/api/v1/stories/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

    end
  end
end
