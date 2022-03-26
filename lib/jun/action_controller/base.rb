# frozen_string_literal: true

require_relative "rendering"
require_relative "redirecting"

module Jun
  module ActionController
    class Base
      include Jun::ActionController::Rendering
      include Jun::ActionController::Redirecting

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
