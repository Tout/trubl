require_relative './pagination'

module Trubl
  class Collection < Array
    
    attr_reader :pagination
    
    def from_response(response, options = {})
      return nil if missing_or_exception?(response)
      json = JSON.parse(response.body)
      @pagination  =  Trubl::Pagination.new.from_response(response)
      self.concat (json[container_name] || []).map{|m| klass.new(m[member_name]) }
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
        code = if response.respond_to?(:code)
          response.code
        elsif response.respond_to?(:status)
          response.status
        else
          nil
        end

        is_missing_or_exception = code && (400..600).include?(code)
        Trubl.logger.warn("Unexposed HTTP #{code}: #{response.body}") if is_missing_or_exception && response.respond_to?(:body)
        return is_missing_or_exception
      end

  end
end
