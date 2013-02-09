require_relative './collection'
require_relative './user'

module Trubl
  class Users < Collection

    def klass
      Trubl::User
    end

    def container_name
      'users'
    end

    def member_name
      'user'
    end

  end
end
