require_relative '../touts'
require_relative '../users'
require_relative '../thumbnails'

# todo: all api modules should simply return responses

module Trubl
  module API
    module Touts
      # implements http://developer.tout.com/api-overview/touts-api

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

      def retrieve_touts_json(uids=[], options={})
        uids = (uids.is_a?(Array) ? uids : [uids]).compact.uniq.sort
        return [] if uids.blank?

        requests = uids.in_groups_of(100, false).collect do |uid_group|
          {path: "touts.json", query: {uids: uid_group.join(',')}.merge(options) }
        end

        multi_request(:get, requests).
          collect { |response| Trubl::Touts.new.from_response_json(response) }.
          flatten.
          compact
      end

      # returns Array of Trubl::Tout instances or nil
      def filter_touts(params={}, options={})
        # post should be used when request params is large
        # TODO: abstract this logic out is needed in another place
        method_name = options[:method] == :post ? :post : :get
        response = send(method_name, "touts/filter", query: params)
        Trubl::Touts.new.from_response(response)
      end

      # returns Trubl::Thumbnails instance or nil
      def retrieve_thumbnails(uid)
        response = get("touts/#{uid}/thumbnails?style=array")
        Trubl::Thumbnails.new.from_response(response)
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
        path = "touts/#{uid}/schedule/by/#{options.delete(:by)}"
        response = post(path, {body: options})

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
    end
  end
end
