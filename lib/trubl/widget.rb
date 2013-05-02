require 'trubl/base'

module Trubl
  class Widget < Trubl::Base

    def user
      Trubl.client.retrieve_user(self.user.uid)
    end

    def anchor_tout
      self.anchor_tout.present? ? Trubl.client.retrieve_tout(self.anchor_tout.uid) : nil
    end

  end
end
