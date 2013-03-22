require_relative '../conversation'
require_relative '../touts'

module Trubl
  module API
    module Conversation

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation
      # returns Trubl::Conversation instance or nil
      def retrieve_conversation(uid)
        response = get("conversations/#{uid}")
        Trubl::Conversation.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation-participants
      # returns Array of Trubl::User instances or nil
      def retrieve_conversation_participants(uid, order=nil, per_page=nil, page=nil)
        response = get("conversations/#{uid}/authors", query: {order: order, per_page: per_page, page: page})
        Trubl::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/conversation-api/apimethod/retrieve-conversation-touts
      # returns Array of Trubl::Tout instances or nil
      def retrieve_conversation_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("conversations/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        Trubl::Touts.new.from_response(response)
      end

    end
  end
end
