module Trubl
  module V2
    class Metrics < Trubl::V2::Base
      def user
        client.user_metrics
      end

      def user_audience
        client.user_metrics_audience
      end

      def user_views
        client.user_metrics_views
      end

    end
  end
end