require_relative './pagination'

module Trubl
  class Collection < Array

    def from_response(response, options = {})
      json = JSON.parse(response.body)
      members = json[container_name].map{|m| klass.new(m[member_name]) }
      members.each do |member|
        self << member
      end
      self
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
      self.class.name.gsub('trubl::', '').downcase
    end

  end
end
