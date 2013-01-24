require_relative './collection'
require_relative './hashtag'

module Trubl
  class Hashtags < Collection
    alias :hashtags :members

    def from_response(response)
      members_from_response(response, "hashtags", Trubl::Hashtag, "hashtag")
      pagination_from_response(response)
      self
    end

  end
end
