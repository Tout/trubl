require 'ostruct'

module Trubl
  class Tout

    def initialize(*args)
      @source = OpenStruct.new(*args)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

    def from_response(response)
      @source = OpenStruct.new(JSON.parse(response.body)["tout"])
      self
    end

  end
end