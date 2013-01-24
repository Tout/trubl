require_relative './collection'
require_relative './user'

module Trubl
  class Users < Collection
    alias :users :members

    def from_response(response)
      members_from_response(response, "users", Trubl::User, "user")
      pagination_from_response(response)
      self
    end

  end
end
