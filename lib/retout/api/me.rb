require 'retout/user'

module ReTout
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      def get_me()
        ReTout::User.new.from_response(get("me"))
      end

    end
  end
end
