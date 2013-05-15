require_relative '../users'

module Trubl
  module API
    module Suggested_Users

      # http://localhost:3000/api/v1/suggested_users.json?access_token=aa054fba7f546a2cafc1f6b960c0742cd45eabb8e188044704efb36ce8d1d5ae&q=puiyee
      # returns Array of Trubl::User instances or nil
      def suggested_users(query, per_page=nil, page=nil)
        response = get("suggested_users.json", query: {q: query, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

    end
  end
end