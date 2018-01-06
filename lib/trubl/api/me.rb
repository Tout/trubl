require_relative '../authorizations'
require_relative '../devices'
require_relative '../digestable_notifications'
require_relative '../hashtags'
require_relative '../notifications'
require_relative '../settings'
require_relative '../streams'
require_relative '../user'
require_relative '../user_notifications'

module Trubl
  module API
    module Me
      # implements http://developer.tout.com/api-overview/me-api

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-authenticated-user
      # returns Trubl::User instance or nil
      def get_me
        Trubl::User.new.from_response(get("me"))
      end

      def get_me_json
        Trubl::User.new.from_response(get("me.json"))
      end

      # TODO update_me should return meaningful exceptions instead of nil
      def update_me(params={})
        return nil if params.blank? or params[:user].blank?

        allowed_properties = [:email, :password, :password_confirmation, :username, :avatar, :fullname, :location, :bio, :headline]
        unallowed_properties = params[:user].keys.map(&:to_sym) - allowed_properties

        raise "#{unallowed_properties.join(', ')} are not supported" if unallowed_properties.present?

        response = put("me", {body: params})

        Trubl::User.new.from_response(response)
      end

      # implements me/authorizations
      def get_my_authorizations
        response = get("me/authorizations")
        Trubl::Authorizations.new.from_response(response)
      end

      # implements me/authorizations
      def get_my_authorizations_json
        response = get("me/authorizations.json")
        Trubl::Authorizations.new.from_response(response)
      end

      def get_my_settings
        response = get("me/settings")
        Trubl::Settings.new.from_response(response)
      end

      def get_my_settings_json
        response = get("me/settings.json")
        Trubl::Settings.new.from_response(response)
      end

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-sharing-settings
      def get_my_fb_sharing_settings
        response = get("me/sharing/facebook")
        JSON.parse(response.body)
      end

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-sharing-settings
      def get_my_fb_sharing_settings_json
        response = get("me/sharing/facebook.json")
        JSON.parse(response.body)
      end

      # returns Array of Trubl::Tout instances or nil
      def get_updates(order="most_recent_first", per_page=nil, page=nil)
        response = get("me/updates", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/me-api/apimethod/retrieve-list-touts-authenticated-user
      # returns Array of Trubl::Tout instances or nil
      def get_my_touts(order="most_recent_first", per_page=nil, page=nil)
        response = get("me/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end
      alias_method :get_my_published_touts, :get_my_touts

      def notifications()
        response = get("me/notifications")
        Trubl::Notifications.new.from_response(response)
      end

      def notification_inbox()
        response = get("me/notification_inbox")
        Trubl::UserNotifications.new.from_response(response)
      end

      def devices
        response = get("me/devices")
        Trubl::Devices.new.from_response(response)
      end

      def streams
        response = get("me/streams")
        Trubl::Streams.new.from_response(response)
      end

      def get_my_scheduled_touts
        response = get("/api/v1/me/touts/scheduled")
        Trubl::Touts.new.from_response(response)
      end

      def get_my_rejected_touts
        response = get("/api/v1/me/touts/rejected")
        Trubl::Touts.new.from_response(response)
      end

      def get_all_my_touts
        response = get("/api/v1/me/touts/all")
        Trubl::Touts.new.from_response(response)
      end

      def get_my_pending_touts
        response = get("/api/v1/me/touts/pending")
        Trubl::Touts.new.from_response(response)
      end
    end
  end
end
