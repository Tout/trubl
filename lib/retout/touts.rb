require 'retout/collection'
require 'retout/tout'

module ReTout
  class Touts < Collection
    alias :touts :members

    def from_response(response)
      members_from_response(response, "touts", ReTout::Tout, "tout")
      pagination_from_response(response)
      self
    end

  end
end