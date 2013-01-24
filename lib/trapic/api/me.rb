require_relative '../user'

module Trapic
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        Trapic::User.new.from_response(get("me"))
      end

    end
  end
end
