require_relative "../client.rb"
module Trubl
  module V2
    class Client < Trubl::Client
      include Truble::V2::Namespaces
    end
  end
end