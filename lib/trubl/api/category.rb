require_relative '../category'
require_relative '../channel'
require_relative '../users'
require_relative '../touts'

module Trubl
  module API
    module Category

      # implements categories/:uid
      # returns Trubl::Category instance or nil
      def retrieve_category(uid)
        response = get("categories/#{uid}")
        Trubl::Category.new(JSON.parse(response.body)["category"])
      end

      # implements categories/:uid/users
      # returns Array of Trubl::User instances or nil
      def retrieve_category_users(uid, order=nil, per_page=nil, page=nil)
        response = get("categories/#{uid}/users", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements categories/:uid/touts
      # returns Array of Trubl::Tout instances or nil
      def retrieve_category_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("categories/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

    end
  end
end