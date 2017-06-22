require_relative './pagination'

module Trubl
  class Collection < Array

    attr_reader :pagination

    def from_response(response, options = {})
      return nil if Trubl::Client.is_problematic_response?(response)
      json = JSON.parse(response.body)
      @pagination  =  Trubl::Pagination.new.from_response(response)
      self.concat (json[container_name] || []).map{|m| klass.new(m[member_name]) }
    end

    def from_response_json(response, options = {})
      return nil if Trubl::Client.is_problematic_response?(response)
      json = JSON.parse(response.body)
    end

    def klass
      "Trubl::#{member_name.classify}".constantize
    end

    def container_name
      klass_name
    end

    def member_name
      klass_name.singularize
    end

    def klass_name
      self.class.name.downcase.gsub('trubl::', '')
    end
  end
end
