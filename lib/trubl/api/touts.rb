require_relative '../touts'
require_relative '../users'

# todo: all api modules should simply return responses

module Trubl
  module API
    module Touts
      # implements http://developer.tout.com/api-overview/touts-api

      # http://developer.tout.com/api/touts-api/apimethod/retrieve-list-featured-touts
      # returns Array of Trubl::Tout instances or nil
      def featured_touts(opts={})
        response = get("featured", query: {per_page: opts[:per_page], page: opts[:page]})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-list-users-who-have-liked-tout
      # returns Array of Trubl::User instances or nil
      def tout_liked_by(uid, order=nil, per_page=nil, page=nil)
        response = get("touts/#{uid}/liked_by", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-tout
      # returns Trubl::Tout instance or nil
      def retrieve_tout(uid)
        response = get("touts/#{uid}")
        Trubl::Tout.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-touts
      # @param uids [Array<String>] of tout uids
      # @return [Array<Trubl::Tout>]
      def retrieve_touts(uids=[])
        uids = (uids.is_a?(Array) ? uids : [uids]).compact.uniq.sort
        return [] if uids.blank?

        requests = uids.in_groups_of(100, false).collect do |uid_group|
          {path: "touts", query: {uids: uid_group.join(',')} }
        end

        multi_request(:get, requests).
          collect { |response| Trubl::Touts.new.from_response(response) }.
          flatten.
          compact
      end

      # returns Array of Trubl::Tout instances or nil
      def filter_touts(params={})
        #raise "tout_uids AND/OR user_uids are required params" if params[:tout_uids].blank? && params[:user_uids].blank?
        response = get("touts/filter", query: params)
        Trubl::Touts.new.from_response(response)
      end

      # returns Array of Trubl::Tout instances or nil
      def retrieve_tout_replies(uid)
        response = get("touts/#{uid}/replies")
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-touts-conversation
      # returns Trubl::Conversation instance or nil
      def retrieve_tout_conversation(uid)
        response = get("touts/#{uid}/conversation")
        Trubl::Conversation.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-latest-touts
      # returns Array of Trubl::Tout instances or nil
      def latest_touts(per_page=nil, page=nil)
        response = get("latest", query: {per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-touts-hashtags-and-users-followed-given-user
      # ToDo: is this api call documented in the right place?
      # returns Array of Trubl::Tout instances or nil
      def retrieve_updates(order=nil, per_page=nil, page=nil)
        response = get("me/updates",query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/create-tout
      # returns Trubl::Tout instance or nil
      def create_tout(params={})
        response = if params[:tout][:url].nil?
          params[:data] = params[:tout].delete(:data)
          multipart_post("touts", params)
        else
          post("/api/v1/touts", {body: params})
        end

        Trubl::Tout.new.from_response(response)
      end

      def update_tout(uid, params={})
        return nil if params.blank? or params[:tout].blank?

        response = put("touts/#{uid}", {body: params})

        Trubl::Tout.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/delete-tout
      # returns true or false
      def delete_tout(uid)
        delete("touts/#{uid}").code == 200
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/tout
      # ToDo: could return an updated Tout object
      # returns true or false
      def like_tout(uid)
        response = post("touts/#{uid}/likes")

        JSON.parse(response.body)["like"]["status"] == "liked"
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/unlike-tout
      # ToDo: could return an updated Tout object
      # returns true or false
      def unlike_tout(uid)
        response = delete("touts/#{uid}/likes")

        JSON.parse(response.body)["like"]["status"] == "not_liked"
      end

      def retout_tout(uid)
        response = post("touts/#{uid}/retouts")
        if response.code == 200
          Trubl::Tout.new.from_response(response)
        else
          nil
        end
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/reply-tout??
      # returns Trubl::Tout instance or nil
      def reply_tout(uid, params={})
        response = if params[:url].nil?
          params[:data] = params[:tout].delete(:data)
          multipart_post("touts/#{uid}/replies", params)
        else
          post("touts/#{uid}/replies", params)
        end

        Trubl::Tout.new.from_response(response)
      end

      # Publish a tout. Takes an optional "by" arg in the options hash (user_uid) that denotes the publisher
      # returns trubl::tout instance or nil
      def publish_tout(uid, options = {})
        path = "touts/#{uid}/publish/by/#{options[:by]}" if options[:by].present?
        path ||= "touts/#{uid}/publish"
        response = put(path)

        Trubl::Tout.new.from_response(response)
      end

      # Schedule a tout. Takes a required "by" arg in the options hash (user_uid) that denotes the publisher
      #                  Also requires "scheduled_at" and "scheduled_date" arguments
      # returns trubl::tout instance or nil
      def schedule_tout(uid, options = {})
        path = "touts/#{uid}/schedule/by/#{options.delete(:by)}" if options[:by].present?
        path ||= "touts/#{uid}/schedule"
        response = post(path, options)

        Trubl::Tout.new.from_response(response)
      end

      # Reject a tout. Takes an optional "by" arg in the options hash (user_uid) that denotes the rejecter
      # returns trubl::tout instance or nil
      def reject_tout(uid, options = {})
        path = "touts/#{uid}/reject/by/#{options.delete(:by)}" if options[:by].present?
        path ||= "touts/#{uid}/reject"
        response = put(path, {body: {rejection_reason: options[:rejection_reason]}})

        Trubl::Tout.new.from_response(response)
      end

       # returns true/false
      def remove_tout_as_reply(uid)
        delete("touts/#{uid}/conversation").code == 200
      end

=begin
      # implements http://developer.tout.com/api/touts-api/apimethod/share-tout
      def share_tout(uid)
        response = post("touts/#{uid}/share")
        raise "Not implemented"
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/update-touts-text
      def update_tout_text(uid)
        response = put("touts/#{uid}.json?")
        raise "Not implemented; see update_tout"
      end
=end
    end
  end
end
