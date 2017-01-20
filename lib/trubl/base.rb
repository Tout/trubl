require 'hashie'

module Trubl
  class Base < Hashie::Mash

    def from_response(response)
      return nil if Trubl::Client.is_problematic_response?(response)
      initialize(parse(response))
    end

    def parse(response)
      JSON.parse(response.body)[klass_name]
    end

    def klass_name
      self.class.name.downcase.gsub('trubl::', '')
    end
  end
end


