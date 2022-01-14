# frozen_string_literal: true

require_relative "rendering"

module Jun
  module ActionController
    class Base
      include Jun::ActionController::Rendering

      attr_accessor :request, :response

      def handle_response(action)
        public_send(action)
        render(action) unless response_rendered?

        response
      end
    end
  end
end
