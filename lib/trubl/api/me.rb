require_relative '../user'

module Trubl
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        Trubl::User.new.from_response(get("me"))
      end

    end
  end
end
