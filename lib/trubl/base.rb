require 'hashie'

module Trubl
  class Base < Hashie::Mash

    def from_response(response)
      return nil if missing_or_exception?(response)
      initialize(parse(response))
    end

    def parse(response)
      JSON.parse(response.body)[klass_name]
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


