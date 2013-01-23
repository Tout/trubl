require 'retout/pagination'

module ReTout
  class Collection < Array
    attr_accessor :pagination, :members

    def members_from_response(response, key, klass, member)
      JSON.parse(response.body)[key].collect{|x| klass.new(x[member])}.compact
    end

    def pagination_from_response(response)
      begin
        Pagination.new.from_response(response)
      rescue NoMethodError
      end
    end

    def [](i)
      @members[i]
    end

    def each
      c = 0
      until c == self.size
        yield self.[](c)
        c += 1
      end
    end

  end
end