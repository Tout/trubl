require 'tout/conversation'
require 'tout/utils'

module Tout
  module API
    module Conversation

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation
      def retrieve_conversation(uid)
        response = get("/api/v1/conversations/#{uid}")
        Tout::Utils.conversation_from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation-participants
      def retrieve_conversation_participants(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/conversations/#{uid}/authors", query: {order: order, per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation-touts
      def retrieve_conversation_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/conversations/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Tout::Utils::Collection.new.from_response(response)
      end

    end
  end
end
