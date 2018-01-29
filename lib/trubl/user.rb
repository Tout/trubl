require 'trubl/base'

module Trubl
  class User < Trubl::Base

    def self.update(uid, params)
      Trubl.client.update_user(uid, params)
    end

    def touts
      Trubl.client.retrieve_user_touts(self.uid)
    end
  end
end
