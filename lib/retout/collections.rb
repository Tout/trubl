require 'retout/conversation'
require 'retout/hashtag'
require 'retout/tout'
require 'retout/user'

module ReTout

  class Pagination
    attr_accessor :current_page, :order, :per_page, :page, :total_entries

    def from_response(response)
      pagination = pagination_from_response(response)
      @order = pagination["order"]
      @current_page = pagination["current_page"]
      @per_page = pagination["per_page"]
      @page = pagination["per_page"]
      @total_entries = pagination["total_entries"]
      self
    end

    def pagination_from_response(response)
      JSON.parse(response.body)["pagination"]
    end
  end

  # make this the base class, have aliases for the touts, users, etc...
  class Collection
    attr_accessor :pagination, :members
    include Enumerable

    def members_from_response(response, key, klass, member)
      JSON.parse(response.body)[key].collect{|x| klass.new(x[member])}.compact
    end

    def [](i)
      @members[i]
    end

    def each
      c = 0
      until c == @members.length
        yield self.[](c)
        c += 1
      end
    end
  end

  class Touts < Collection
    alias :touts :members

    def from_response(response)
      @members = members_from_response(response, "touts", ReTout::Tout, "tout")
      @pagination = Pagination.new.from_response(response)
      self
    end

  end

  class Users < Collection
    alias :users :members

    def from_response(response)
      @members = members_from_response(response, "users", ReTout::User, "user")
      @pagination = Pagination.new.from_response(response)
      self
    end

  end

  class Hashtags < Collection
    alias :hashtags :members

    def from_response(response)
      @members = members_from_response(response, "hashtags", ReTout::Hashtag, "hashtag")
      begin
        @pagination = Pagination.new.from_response(response)
      rescue NoMethodError
      end
      self
    end

  end
end