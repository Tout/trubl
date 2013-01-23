require 'ostruct'

module ReTout
  class Hashtag

    def initialize(opts)
      @source = OpenStruct.new(opts)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

  end
end