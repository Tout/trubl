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
        response.respond_to?(:code) && (400..600).include?(response.code)
      end

  end
end


