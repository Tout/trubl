require_relative './pagination'

module ReTout
  class Collection < Array
    attr_accessor :pagination, :members

    def members_from_response(response, key, klass, member)
      #self << JSON.parse(response.body)[key].collect{|x| klass.new(x[member])}.compact
      JSON.parse(response.body)[key].each do |x|
        self << klass.new(x[member])
      end
    end

    def pagination_from_response(response)
      begin
        @pagination = Pagination.new.from_response(response)
      rescue NoMethodError
      end
    end


  end
end
