require_relative '../touts'
require_relative '../users'

# todo: all api modules should simply return responses

module Trubl
  module API
    module Touts

      # http://developer.tout.com/api/touts-api/apimethod/retrieve-list-featured-touts
      def featured_touts(per_page=nil, page=nil)
        response = get("featured", query: {per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-list-users-who-have-liked-tout
      def tout_liked_by(uid, order=nil, per_page=nil, page=nil)
        response = get("touts/#{uid}/liked_by", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-tout
      def retrieve_tout(uid)
        response = get("touts/#{uid}")
        Trubl::Tout.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-touts-conversation
      def retrieve_tout_conversation(uid)
        response = get("touts/#{uid}/conversation")
        Trubl::Conversation.new(JSON.parse(response.body)["conversation"])
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-latest-touts
      def latest_touts(per_page=nil, page=nil)
        response = get("latest", query: {per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/retrieve-touts-hashtags-and-users-followed-given-user
      # ToDo: is this api call documented in the right place?
      def retrieve_updates(order=nil, per_page=nil, page=nil)
        response = get("me/updates",query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/create-tout
      def create_tout(params={})
        response = if params[:url].nil?
          params[:data] = params[:tout].delete(:data)
          multipart_post("touts", params)
        else
          post("touts", params)
        end

        Trubl::Tout.new.from_response(response)
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/delete-tout
      def delete_tout(uid)
        response = delete("touts/#{uid}")
        if response.code == 200
          true
        else
          false
        end
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/tout
      # ToDo: could return an updated Tout object
      def like_tout(uid)
        response = post("touts/#{uid}/likes")
        if JSON.parse(response.body)["like"]["status"] == "liked"
          true
        else
          false
        end
      end

      # implements http://developer.tout.com/api/touts-api/apimethod/unlike-tout
      # ToDo: could return an updated Tout object
      def unlike_tout(uid)
        response = delete("touts/#{uid}/likes")
        if JSON.parse(response.body)["like"]["status"] == "not_liked"
          true
        else
          false
        end
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
        raise "Not implemented"
      end
=end
    end
  end
end
