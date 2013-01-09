module Tout
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        response = get("/api/v1/me")
      end

    end
  end
end
