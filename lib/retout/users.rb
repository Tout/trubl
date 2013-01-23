require 'retout/collection'
require 'retout/user'

module ReTout
  class Users < Collection
    alias :users :members

    def from_response(response)
      members_from_response(response, "users", ReTout::User, "user")
      pagination_from_response(response)
      self
    end

  end
end