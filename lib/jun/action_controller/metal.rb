# frozen_string_literal: true

module Jun
  module ActionController
    class Metal
      attr_accessor :request, :response

      def handle_response(action)
        public_send(action)
        render(action) unless response_rendered?

        response
      end

      private

      def response_rendered?
        !!@_response_rendered
      end
    end
  end
end
