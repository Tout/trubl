require 'ostruct'
require 'retout/utils'

module ReTout
  class User

    def initialize(opts)
      @source = OpenStruct.new(opts)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

  end
end