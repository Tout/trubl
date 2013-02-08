require 'ostruct'
require_relative './utils'

module Trubl
  class Channel

    def initialize(*args)
      @source = OpenStruct.new(*args)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

    def from_response(response)
      @source = OpenStruct.new(JSON.parse(response.body)["channel"])
      self
    end

  end
end
