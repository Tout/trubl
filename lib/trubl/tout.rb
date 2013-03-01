require 'trubl/base'

module Trubl
  class Tout < Trubl::Base
    
    def delete
      Trubl.client.delete_tout(self.uid)
    end

    def like
      Trubl.client.like_tout(self.uid)
    end

    def unlike
      Trubl.client.unlike_tout(self.uid)
    end

=begin
    def share
      Trubl.client.share_tout(self.uid)
    end

    def update_text
      Trubl.client.update_tout_text(self.uid)
    end
=end

  end
end
