require_relative './collection'
require_relative './hashtag'

module Trubl
  class Hashtags < Collection

    def klass
      Trubl::Hashtag
    end

    def container_name
      'hashtags'
    end

    def member_name
      'hashtag'
    end

  end
end
