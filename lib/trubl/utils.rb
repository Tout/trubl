require 'uri'


module Trubl
  module Utils
    class << self

      def uri_builder(*str)
        URI.join(*str).to_s
      end

    end
  end
end