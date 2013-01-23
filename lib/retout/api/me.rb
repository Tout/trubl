require_relative '../utils'

module ReTout
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        ReTout::Utils.user_from_response(get("me"))
      end

    end
  end
end
