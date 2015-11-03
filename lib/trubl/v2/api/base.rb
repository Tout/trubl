module Trubl
  module V2
    class Base
      attr_accessor :client

      def initalize client, opts
        @client = client
        @opts = opts
      end

      def get *args
        client.get(*args)
      end

      def post *args
        client.post(*args)
      end

      def put *args
        client.put(*args)
      end

      def delete *args
        client.delete(*args)
      end

      def patch *args
        client.patch(*args)
      end

      private

        def per_page(opts)
          opts[:per_page]
        end

        def page(opts)
          opts[:page]
        end

        def order(opts)
          opts[:order]
        end
    end

  end
end
