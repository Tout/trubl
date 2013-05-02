require_relative './collection'
require_relative './widget'

module Trubl
  class Widgets < Collection

    def klass
      Trubl::Widget
    end

    def container_name
      'widgets'
    end

    def member_name
      'widget'
    end

  end
end
