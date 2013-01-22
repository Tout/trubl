require 'ostruct'

module ReTout
  class Tout
    def initialize(opts)
      @source = OpenStruct.new(opts)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end
  end
end