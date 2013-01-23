require 'retout/collection'
require 'retout/hashtag'

module ReTout
  class Hashtags < Collection
    alias :hashtags :members

    def from_response(response)
      @members = members_from_response(response, "hashtags", ReTout::Hashtag, "hashtag")
      @pagination = pagination_from_response(response)
      self
    end

  end
end
