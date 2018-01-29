require 'trubl/base'

module Trubl
  class Tout < Trubl::Base
    def delete
      Trubl.client.delete_tout(self.uid)
    end
  end
end
