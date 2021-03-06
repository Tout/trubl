require_relative '../touts'
require_relative '../user'
require_relative '../users'

module Trubl
  module API
    module Users
      # implements http://developer.tout.com/api-overview/users-api
      # mixed in to a Client instance, the self passed to response objects is that instance

      def featured_users(per_page=nil, page=nil)
        response = get("featured_users", query: {per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-user
      # @param uid [String] a user uid
      # @return [Trubl::User] or nil
      def retrieve_user(uid=nil)
        return nil if uid.blank?

        response = get("users/#{uid}")
        Trubl::User.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users
      # @param uids [Array<String>] of user uids
      # @return [Array<Trubl::User>]
      def retrieve_users(uids=[])
        uids = (uids.is_a?(Array) ? uids : [uids]).compact.uniq.sort
        return [] if uids.blank?

        requests = uids.in_groups_of(100, false).collect do |uid_group|
          {path: "users", query: {uids: uid_group.join(',')} }
        end

        multi_request(:get, requests).
          collect { |response| Trubl::Users.new.from_response(response) }.
          flatten.
          compact
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users-touts
      # return Array of Trubl::Tout instances or nil
      def retrieve_user_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("users/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

      # takes standard user params, with or without toplevel user node
      # http://tout.github.io/api-docs/static/resources/me/id.html#put
      # can pass a file reference for the avatar
      # returns response object
      def update_user(uid, params) # :nodoc:
        params = {user: params} if params[:user].blank?
        avatar = params[:user][:avatar]
        if avatar.respond_to? :original_filename
          file = avatar.tempfile
          content_type = avatar.content_type
          filename = avatar.original_filename
          params[:user][:avatar] = UploadIO.new(file, content_type, filename)
        else
          params[:user].delete :avatar
        end
        put("users/#{uid}", body: params)
      end

      # returns the new user response object
      def create_user(params)
        params = {user: params} if params[:user].blank?
        post("/api/v1/users", body: params)
      end

      # returns true/false
      def update_watermark_from_url(uid, watermark_url)
        response = put("users/#{uid}/watermark", body: {watermark: {image_url: watermark_url}})
        (200...300).include?(response.code)
      end
    end
  end
end
