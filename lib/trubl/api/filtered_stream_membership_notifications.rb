module Trubl
  module API
    module FilteredStreamMembershipNotifications

      # Takes a list of tout ids and notifies kicktag that their stream
      # memberships have been created or deleted
      def filtered_stream_membership_notify_create(ids)
        params = {tout_ids: ids}
        response = post("/api/v1/filtered_stream_membership_notifications/create", {query: params})
      end

      def filtered_stream_membership_notify_destroy(ids)
        params = {tout_ids: ids}
        response = post("/api/v1/filtered_stream_membership_notifications/destroy", {query: params})
      end
    end
  end
end
