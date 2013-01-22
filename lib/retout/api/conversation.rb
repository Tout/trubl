require 'retout/conversation'
require 'retout/utils'

module ReTout
  module API
    module Conversation

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation
      def retrieve_conversation(uid)
        response = get("conversations/#{uid}")
        ReTout::Utils.conversation_from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation-participants
      def retrieve_conversation_participants(uid, order=nil, per_page=nil, page=nil)
        response = get("conversations/#{uid}/authors", query: {order: order, per_page: per_page, page: page})
        ReTout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation-touts
      def retrieve_conversation_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("conversations/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        ReTout::Utils::Collection.new.from_response(response)
      end

    end
  end
end
