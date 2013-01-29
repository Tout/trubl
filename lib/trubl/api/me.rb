require_relative '../user'

module Trubl
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        Trubl::User.new.from_response(get("me"))
      end

      def get_my_fb_sharing_settings()
        response = get("me/sharing/facebook")
        response.parsed_response
      end

    end
  end
end
