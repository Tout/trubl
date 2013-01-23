require 'retout/collection'
require 'retout/hashtag'

module ReTout
  class Hashtags < Collection
    alias :hashtags :members

    def from_response(response)
      members_from_response(response, "hashtags", ReTout::Hashtag, "hashtag")
      pagination_from_response(response)
      self
    end

  end
end
