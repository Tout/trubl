require 'ostruct'


module Tout
  module Touts
    # silly namespace collision workaround
    class Tout
      def initialize(opts)
        @source = OpenStruct.new(opts)
      end

      def method_missing(method, *args, &block)
        @source.send(method, *args, &block)
      end
    end
  end
end