require_relative './collection'
require_relative './tout'

module Trubl
  class Touts < Collection

    def klass
      Trubl::Tout
    end

    def container_name
      'touts'
    end

    def member_name
      'tout'
    end

  end
end
