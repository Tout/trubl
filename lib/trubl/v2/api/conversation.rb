module Trubl
  module V2
    class Conversation < Trubl::V2::Base
      def find(uid, opts={})
        client.retrieve_conversations(uid)
      end

      def participants(uid, opts={})
        client.retrieve_conversation_participants(uid, order(opts), per_page(opts), page(opts)))
      end

      def touts(uid, opts={})
        client.retrieve_conversation_touts(uid, order(opts), per_page(opts), page(opts)))
      end
    end
  end
end