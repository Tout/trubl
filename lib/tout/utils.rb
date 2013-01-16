require 'tout/conversation'
require 'tout/tout'
require 'tout/user'
require 'uri'


module Tout
  module Utils

    class << self

      def conversation_from_response(data)
        Tout::Conversation.new(JSON.parse(data.body)["conversation"])
      end

      def uri_builder(*str)
        URI.join(*str).to_s
      end

      def pagination_from_response(data)
        begin
          Pagination.new(JSON.parse(data.body)["pagination"])
        rescue NoMethodError
        end
      end

      def tout_from_response(data)
        Tout::Touts::Tout.new(JSON.parse(data.body)["tout"])
      end

      def touts_from_response(data)
        begin
          JSON.parse(data.body)["touts"].collect{|x| Tout::Touts::Tout.new(x["tout"])}.compact
        rescue NoMethodError
        end
      end

      def user_from_response(data)
        Tout::User.new(JSON.parse(data.body)["user"])
      end

      def users_from_response(response)
        begin
          JSON.parse(response.body)["users"].collect{|x| Tout::User.new(x["user"])}.compact
        rescue NoMethodError
        end
      end

      def hashtags_from_response(response)
        begin
          JSON.parse(response.body)["hashtags"].collect{|x| x["hashtag"]}.compact
        rescue NoMethodError
        end
      end

    end

    class Collection
      attr_accessor :pagination, :touts, :users, :hashtags

      # ToDo: as we define better objects, enable them to be parsed better (e.g. turn "user" into Tout::User instance)

      def from_response(response)
        @touts = Tout::Utils.touts_from_response(response)
        @users = Tout::Utils.users_from_response(response)
        @pagination = Tout::Utils.pagination_from_response(response)
        @hashtags = Tout::Utils.hashtags_from_response(response)
        self
      end
    end

    class Pagination
      attr_accessor :current_page, :order, :per_page, :page, :total_entries

      def initialize(options)
        @order = options["order"]
        @current_page = options["current_page"]
        @per_page = options["per_page"]
        @page = options["per_page"]
        @total_entries = options["total_entries"]
      end
    end

  end
end