require_relative '../api/category.rb'
require_relative '../api/channel.rb'
require_relative '../api/conversation.rb'
require_relative '../api/feeds.rb'
require_relative '../api/hashtags.rb'
require_relative '../api/leaderboard.rb'
require_relative '../api/me.rb'
require_relative '../api/metrics.rb'
require_relative '../api/playlists.rb'
require_relative '../api/search.rb'
require_relative '../api/stories.rb'
require_relative '../api/streams.rb'
require_relative '../api/suggested_users.rb'
require_relative '../api/touts.rb'
require_relative '../api/users.rb'

module Trubl
  module V2
    module Namespaces
      extend ActiveSupport::Concern
      included do
        def category
          @category ||= Trubl::V2::Api::Category.new(self)
        end

        def channel
          @channel ||= Trubl::V2::Api::Channel.new(self)
        end

        def conversation
          @conversation ||= Trubl::V2::Api::Conversation.new(self)
        end

        def feeds
          @feeds ||= Trubl::V2::Api::Feeds.new(self)
        end

        def hashtags
          @hashtags ||= Trubl::V2::Api::Hashtags.new(self)
        end

        def leaderboards
          @leaderboards ||= Trubl::V2::Api::Leaderboards.new(self)
        end

        def me
          @me ||= Trubl::V2::Api::Me.new(self)
        end

        def metrics
          @metrics ||= Trubl::V2::Api::Metrics.new(self)
        end

        def playlists
          @playlists ||= Trubl::V2::Api::Playlists.new(self)
        end

        def search
          @search ||= Trubl::V2::Api::Search.new(self)
        end

        def stories
          @stories ||= Trubl::V2::Api::Stories.new(self)
        end

        def streams
          @streams ||= Trubl::V2::Api::Streams.new(self)
        end

        def suggested_users
          @suggested_users ||= Trubl::V2::Api::SuggestedUsers.new(self)
        end

        def touts
          @touts ||= Trubl::V2::Api::Touts.new(self)
        end

        def users
          @users ||= Trubl::V2::Api::Users.new(self)
        end
      end

    end
  end
end