require_relative './pagination'

module Trubl
  class Collection < Array

    def from_response(response, options = {})
      return nil if missing_or_exception?(response)
      json = JSON.parse(response.body)
      self.concat json[container_name].map{|m| klass.new(m[member_name]) }
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

    private

      def missing_or_exception?(response)
        response.respond_to?(:code) && (400..600).include?(response.code)
      end

  end
end
