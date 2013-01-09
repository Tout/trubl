require 'tout/tout'
require 'tout/user'


module Tout
  module Utils

    def pagination_from_response(response)
      response["pagination"]
    end

    def tout_from_response(response)
      Tout::Touts::Tout.new(response)
    end

    def touts_from_response(response)
      begin
        response["touts"].collect{|x| Tout::Touts::Tout.new(x["tout"])}.compact
      rescue NoMethodError
      end

    end

    def user_from_response(response)
      Tout::User.new(JSON.parse(response.body)["user"])
    end

    def users_from_response(response)
      begin
        response["users"].collect{|x| Tout::User.new(x["user"])}.compact
      rescue NoMethodError
      end
    end

    class Collection
      include Tout::Utils
      attr_accessor :pagination, :touts, :users

      # ToDo: as we define better objects, enable them to be parsed better (e.g. turn "user" into Tout::User instance)

      def from_response(response)
        @touts = touts_from_response(response)
        @users = users_from_response(response)
        @pagination = pagination_from_response(response)
        self
      end

    end
  end
end