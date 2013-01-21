require 'tout/utils'

module Tout
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        Tout::Utils.user_from_response(get("me"))
      end

    end
  end
end
