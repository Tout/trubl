require_relative '../metrics'

module Trubl
  module API
    module Metrics

      def user_metrics
        response = get("metrics/me")
        Trubl::Metrics.new.from_response(response)
      end

      def user_metrics_audience
        response = get("metrics/me/audience/inception")
        Trubl::Metrics.new.from_response(response)
      end

      def user_metrics_views
        response = get("metrics/me/views/inception")
        Trubl::Metrics.new.from_response(response)
      end

    end
  end
end
